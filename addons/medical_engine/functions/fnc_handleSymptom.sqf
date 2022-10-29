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

	{
		_x params ["_symptomClass", "_mainPart", "_severity", "_causeSymptom", "_reduceSymptom"];
		private _symptomIndex = _forEachIndex;

		if(isNil "_x") then {_symptomInfo = _symptomInfo deleteAt _symptomIndex;continue};
		if!(_symptomClass in EGVAR(meidical,symptomsDetails)) then {continue};

		EGVAR(meidical,symptomsDetails) get _symptomClass params [
			"", "",
			"_selections",
			"_maxSeverity",
			"_visableLevel", "_visableValue",
			"_causeSymptom_Data", "_reduceSymptom_Data",
			"_changeValue",
			"_symptomHandlers"
		];

		if(isNil "_causeSymptom") then {
			_causeSymptom = _causeSymptom_Data;
		};
		if(isNil "_reduceSymptom") then {
			_reduceSymptom = _reduceSymptom_Data;
		};

		// 心率
		private _unitHR = GETHR(_unit);
		private _HR = _unitHR;

		private _targeHR = _changeValue get "targetHR";
		private _targeHR = (_targeHR # 1 - _targeHR # 0) * _severity;
		if((_unitHR - DEFAULT_HR) * _targeHR > 0 ) then {
			if(abs _targeHR > abs(_unitHR - DEFAULT_HR)) then {
				_HR = 0 max (DEFAULT_HR+_targeHR);
			};
		} else {_HR = 0 max (_unitHR+_targeHR)};

		SETHR_T(_unit,_HR);

		private _changeHR = _changeValue get "changeHR";
		private _changeHR = (_changeHR # 1 - _changeHR # 0) * _severity;
		_HR = 0 max (_HR + _changeHR);

		SETHR(_unit,_HR);

		// 血压
		private _unitRR = GETRR(_unit);
		private _RR_Low = _unitRR # 0;
		private _RR_High = _unitRR # 1;

		private _tragetRR = _changeValue get "tragetRR";
		private _tragetRR_Low  = (_tragetRR # 1 - _tragetRR # 0) * _severity;
		private _tragetRR_High = (_tragetRR # 3 - _tragetRR # 2) * _severity;
		if((_RR_Low - DEFAULT_RR_LOW) * _tragetRR_Low > 0 ) then {
			if(abs _tragetRR_Low > abs(_RR_Low - DEFAULT_RR_LOW)) then {
				_RR_Low = 0 max (DEFAULT_RR_LOW + _tragetRR_Low);
			};
		} else {_RR_Low = 0 max (_RR_Low + _tragetRR_Low)};
		if((_RR_High - DEFAULT_RR_HIGH) * _tragetRR_High > 0 ) then {
			if(abs _tragetRR_High > abs(_RR_High - DEFAULT_RR_HIGH)) then {
				_RR_High = _RR_Low max (DEFAULT_RR_HIGH + _tragetRR_High);
			};
		} else {_RR_High = _RR_Low max (_RR_High + _tragetRR_High)};

		SETRR_T(_unit,[ARR_2(_RR_Low,_RR_High)]);

		private _changeRR = _changeValue get "changeRR";
		private _changeRR_Low  = (_changeRR # 1 - _changeRR # 0) * _severity;
		private _changeRR_High = (_changeRR # 3 - _changeRR # 2) * _severity;
		_RR_Low = 0 max (_spo2 + _changeRR_Low);
		_RR_High = 0 max (_spo2 + _changeRR_High);

		SETRR(_unit,[ARR_2(_RR_Low,_RR_High)]);

		// 血氧
		private _unitSpo2 = GETSPO2(_unit);
		private _spo2 = _unitSpo2;

		private _tragetSpo2 = _changeValue get "tragetSpO2";
		private _tragetSpo2 = (_tragetSpo2 # 1 - _tragetSpo2 # 0) * _severity;
		if((_unitSpo2 - DEFAULT_SPo2) * _tragetSpo2 > 0 ) then {
			if(abs _tragetSpo2 > abs(_unitSpo2 - DEFAULT_SPo2)) then {
				_spo2 = 0 max (DEFAULT_SPo2 + _tragetSpo2);
			};
		} else {_spo2 = 0 max (_unitSpo2 + _tragetSpo2)};

		SETSPO2_T(_unit,_spo2);

		private _changeSpo2 = _changeValue get "changeSpO2";
		private _changeSpo2 = (_changeSpo2 # 1 - _changeSpo2 # 0) * _severity;
		_HR = 0 max (_spo2 + _changeSpo2);

		SETSPO2(_unit,_spo2);

		// 血液流失
		if("Bloodloss" in _changeValue) then {
			private _bloodloss = _changeValue get "Bloodloss";
			_bloodloss  = (_bloodloss # 1 - _bloodloss # 0) * _severity;
			private _unitBloodVolume = GETBLOODVOLUME(_unit);
			SETBLOODVOLUME(_unit,_unitBloodVolume - _bloodloss);
		};

		// 症状好转
		// private _selfReduce = _changeValue get "selfReduce";
		// _changeValue set ["selfReduce", _selfReduce]
		// _symptomInfo set [_symptomIndex, ];

		// 特殊类型处理
		private _type = _changeValue get "TYPE";
		switch(_type) do {
			case"Wound": {
				
			};
			case"Symptom": {

			};
		};

		// 导致&减少
		{
			_x params ["_causeSymptomClass","_type","_addPart","_threshold","_perAdd",["_repeat", -1]];

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
		private _symptomData = [_unit, _symptomClass, _hitPart, _severity];
		{
			private _returnValue = _symptomData call _x;

			if (toLower(_returnValue) isEqualType "exit") then {
				break;
			} else {
				_symptomInfo set [_symptomIndex, _returnValue];
			};
		} forEach _symptomHandlers;
		
	}forEach _symptomInfo;

	_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;