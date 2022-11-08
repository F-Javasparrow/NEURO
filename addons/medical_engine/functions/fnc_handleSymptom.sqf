#include "script_component.hpp"
params["_unit"];

if (_unit getVariable [QEGVAR(medical,Symptom_PFH), false]) exitWith {};
_unit setVariable [QEGVAR(medical,Symptom_PFH), true];

if (!local _unit) then {
    ["handleSymptom", [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
	params ["_args", "_idPFH"];
    _args params ["_unit"];
	if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QEGVAR(medical,Symptom_PFH), nil];
    };

	private _symptomInfo = _unit getVariable [QEGVAR(medical,symptomInfo),[]];
	private _medicationInfo = _unit getVariable [QEGVAR(medical,medicationInfo),[]];

	{
		_x params ["_symptomClass", "_mainPart", "_severity", "_causeSymptom", "_reduceSymptom"];
		private _symptomIndex = _forEachIndex;

		if(isNil "_x") then {_symptomInfo = _symptomInfo deleteAt _symptomIndex;continue};
		if!(_symptomClass in EGVAR(meidical,TypeCache)) then {continue};
		
		EGVAR(meidical,symptomsDetails) get _symptomClass params [
			"", "",
			"_selections",
			"_maxSeverity",
			"_visableLevel", "_visableValue",
			"_causeSymptom_Data", "_reduceSymptom_Data",
			"_data",
			"_symptomHandlers"
		];

		if(isNil "_causeSymptom") then {
			_causeSymptom = _causeSymptom_Data;
		};
		if(isNil "_reduceSymptom") then {
			_reduceSymptom = _reduceSymptom_Data;
		};

		// 特殊类型处理
		private _type = _data get "TYPE";

		// 心率 & 血压 & 血氧
		private _targetHR = _data get "targetHR";
		private _changeHR = _data get "changeHR";
		_targetHR = (_targetHR # 1 - _targetHR # 0) * _severity + _targetHR # 0;
		_changeHR = (_changeHR # 1 - _changeHR # 0) * _severity + _changeHR # 0;
		[_unit, _targetHR, _changeHR] call FUNC(updatingHR);

		private _targetRR = _data get "targetRR";
		private _changeRR = _data get "changeRR";
		private _targetRR_Low  = (_targetRR # 1 - _targetRR # 0) * _severity + _targetRR # 0;
		private _targetRR_High = (_targetRR # 3 - _targetRR # 2) * _severity + _targetRR # 2;
		private _changeRR_Low  = (_changeRR # 1 - _changeRR # 0) * _severity + _changeRR # 0;
		private _changeRR_High = (_changeRR # 3 - _changeRR # 2) * _severity + _changeRR # 2;
		[_unit, [_targetRR_Low, _targetRR_High], [_changeRR_Low, _changeRR_High]] call FUNC(updatingRR);

		private _targetSpo2 = _data get "targetSpO2";
		private _changeSpo2 = _data get "changeSpO2";
		_targetSpo2 = (_targetSpo2 # 1 - _changeSpo2 # 0) * _severity + _changeSpo2 # 0;
		_changeSpo2 = (_changeSpo2 # 1 - _changeSpo2 # 0) * _severity + _changeSpo2 # 0;
		[_unit, _targetSpo2, _changeSpo2] call FUNC(updatingSpo2);

		// 血液流失(可选)
		if("Bloodloss" in _data) then {
			private _bloodloss = _data get "Bloodloss";
			_bloodloss  = (_bloodloss # 1 - _bloodloss # 0) * _severity + _bloodloss # 0;
			private _unitBloodVolume = GETBLOODVOLUME(_unit);
			
			SETBLOODVOLUME(_unit,_unitBloodVolume - _bloodloss);
		};

		// 导致 & 减少
		{
			_x params ["_causeSymptomClass", "_type", "_addPart", "_threshold", "_perAdd", ["_repeat", -1]];

			if(_threshold <= _severity) then {
				if(_repeat != -1) then {
					if(_repeat < 1 && random 1 > _repeat) then {
						_causeSymptom deleteAt _forEachIndex;
					};
					if(_repeat >= 1) then {
						_x set [_forEachIndex, _repeat - 1];
					};
				};

				if(_addPart isEqualTo "_SAME_") then {_addPart = _mainPart};

				[QEGVAR(medical,addSymptom), [_unit, _causeSymptomClass, _addPart, [_type, _perAdd]]] call CBA_fnc_localEvent;
			};
		}forEach _causeSymptom;
		_x set [3, _causeSymptom];
		{
			_x params ["_reduceSymptomClass","_type","_reducePart","_threshold","_perReduce",["_repeat", -1]];

			if(_threshold <= _severity) then {
				if(_repeat != -1) then {
					if(_repeat < 1 && random 1 > _repeat) then {
						_reduceSymptom deleteAt _forEachIndex;
					};
					if(_repeat >= 1) then {
						_x set [_forEachIndex, _repeat - 1];
					};
				};

				if(_reducePart isEqualTo "_SAME_") then {_reducePart = _mainPart};

				[QEGVAR(medical,removeSymptom), [_unit, _reduceSymptomClass, _reducePart, [_type, _perReduce]]] call CBA_fnc_localEvent;
			};
		}forEach _reduceSymptom;
		_x set [4, _reduceSymptom];

		// 症状独立函数
		private _symptomData = [_unit, _symptomClass, _mainPart, _severity];
		{
			private _returnValue = _symptomData call _x;

			if ((typeName _returnValue) isEqualTo "STRING" ) then {
				if((toLower _returnValue) isEqualType "exit") then {break};
			} else {
				reverse _returnValue;
				_returnValue resize 3;
				reverse _returnValue;
				_symptomInfo set [_symptomIndex, _returnValue];
			};
		} forEach _symptomHandlers;

		// 症状好转
		private _selfReduce = _data get "selfReduce";
		_x set [2, 0 max (_severity - _selfReduce) min _maxSeverity];
		
	}forEach _symptomInfo;

	{
		_x params ["_medicationClass", "_mainPart", "_severity", "_causeSymptom", "_reduceSymptom"];
		private _medicationIndex = _forEachIndex;

		if(isNil "_x" || _severity <= 0) then {_medicationInfo = _medicationInfo deleteAt _medicationIndex;continue};
		if!(_medicationClass in EGVAR(meidical,medicationTypeCache)) then {continue};

		EGVAR(meidical,medicationDetails) get _medicationClass params [
			"", "",
			"_selections",
			"_timeInSystem", "_efficiency",
			"_causeSymptom_Data", "_reduceSymptom_Data",
			"_data",
			"_medicationHandlers"
		];

		if(isNil "_causeSymptom") then {
			_causeSymptom = _causeSymptom_Data;
		};
		if(isNil "_reduceSymptom") then {
			_reduceSymptom = _reduceSymptom_Data;
		};

		// 特殊类型处理
		private _type = _data get "TYPE";

		// 心率 & 血压 & 血氧
		private _unitHR = GETHR(_unit);
		private _changeHR = _data get "changeHR";
		private _changeHR = (_changeHR # 1 - _changeHR # 0) * _severity + _changeHR # 0;
		_unitHR = 0 max (_unitHR + _changeHR);
		SETHR(_unit,_unitHR);
		
		private _unitRR = GETRR(_unit);
		private _RR_Low = _unitRR # 0;
		private _RR_High = _unitRR # 1;
		private _changeRR = _data get "changeRR";
		private _changeRR_Low  = (_changeRR # 1 - _changeRR # 0) * _severity + _changeRR # 0;
		private _changeRR_High = (_changeRR # 3 - _changeRR # 2) * _severity + _changeRR # 2;
		_RR_Low = 0 max (_RR_Low + _changeRR_Low);
		_RR_High = 0 max (_RR_High + _changeRR_High);
		SETRR(_unit,[ARR_2(_RR_Low,_RR_High)]);

		private _unitSpo2 = GETSPO2(_unit);
		private _changeSpo2 = _data get "changeSpO2";
		private _changeSpo2 = (_changeSpo2 # 1 - _changeSpo2 # 0) * _severity + _changeSpo2 # 0;
		_unitSpo2 = 0 max (_unitSpo2 + _changeSpo2);
		SETSPO2(_unit,_unitSpo2);

		// 粘度
		private _changeViscosity = _data get "changeViscosity";
		_changeViscosity  = (_changeViscosity # 1 - _changeViscosity # 0) * _severity + _changeViscosity # 0;
		private _unitViscosity = GETVISCOSITY(_unit);
			
		GETVISCOSITY(_unit,_unitViscosity - _changeViscosity);

		// 导致 & 减少
		{
			_x params ["_causeSymptomClass", "_type", "_addPart", "_threshold", "_perAdd", ["_repeat", -1]];

			if(_threshold <= _severity) then {
				if(_repeat != -1) then {
					if(_repeat < 1 && random 1 > _repeat) then {
						_causeSymptom deleteAt _forEachIndex;
					};
					if(_repeat >= 1) then {
						_x set [_forEachIndex, _repeat - 1];
					};
				};

				if(_addPart isEqualTo "_SAME_") then {_addPart = _mainPart};

				[QEGVAR(medical,addSymptom), [_unit, _causeSymptomClass, _addPart, [_type, _perAdd]]] call CBA_fnc_localEvent;
			};
		}forEach _causeSymptom;
		_x set [3, _causeSymptom];
		{
			_x params ["_reduceSymptomClass","_type","_reducePart","_threshold","_perReduce",["_repeat", -1]];

			if(_threshold <= _severity) then {
				if(_repeat != -1) then {
					if(_repeat < 1 && random 1 > _repeat) then {
						_reduceSymptom deleteAt _forEachIndex;
					};
					if(_repeat >= 1) then {
						_x set [_forEachIndex, _repeat - 1];
					};
				};

				if(_reducePart isEqualTo "_SAME_") then {_reducePart = _mainPart};

				[QEGVAR(medical,removeSymptom), [_unit, _reduceSymptomClass, _reducePart, [_type, _perReduce]]] call CBA_fnc_localEvent;
			};
		}forEach _reduceSymptom;
		_x set [4, _reduceSymptom];

		// 药效减少
		_x set [2, 0 max (_severity - (1 / (_timeInSystem # 0 + _timeInSystem # 1))) min 1];

	}forEach _medicationInfo;

	_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];
	_unit setVariable [QEGVAR(medical,medicationInfo), _medicationInfo];
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;