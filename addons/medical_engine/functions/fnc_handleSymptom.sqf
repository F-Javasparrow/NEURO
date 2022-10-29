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
		_x params ["_symptomClass", "_hitPart", "_severity", "_causeSymptom", "_reduceSymptom"];
		_hitPart params ["_mainPart", "_subPart"];

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
		private _changeHR = _changeValue get "HR";
		private _changeHR = (_changeHR # 0 - _changeHR # 1) * _severity;
		private _unitHR = GETHR(_unit);

		if((_unitHR - DEFAULT_HR) * _changeHR > 0 ) then {
			if(abs _changeHR > abs(_unitHR - DEFAULT_HR)) then {
				SETHR(_unit,0 max (DEFAULT_HR+_changeHR));
			};
		} else {SETHR(_unit,0 max (_unitHR+_changeHR))};

		// 血压
		private _changeRR = _changeValue get "RR";
		private _unitRR = GETRR(_unit);
		private _changeRR_Low  = (_changeRR # 0 - _changeRR # 1) * _severity;
		private _changeRR_High = (_changeRR # 2 - _changeRR # 3) * _severity;
		private _unitRR_Low = _unitRR # 0;
		private _unitRR_High = _unitRR # 1;

		if((_unitRR_Low - DEFAULT_RR_LOW) * _changeRR_Low > 0 ) then {
			if(abs _changeRR_Low > abs(_unitRR_Low - DEFAULT_RR_LOW)) then {
				_unitRR_Low = 0 max (DEFAULT_RR_LOW + _changeRR_Low);
			};
		} else {_unitRR_Low = 0 max (_unitRR_Low + _changeRR_Low)};

		if((_unitRR_High - DEFAULT_RR_HIGH) * _changeRR_High > 0 ) then {
			if(abs _changeRR_High > abs(_unitRR_High - DEFAULT_RR_HIGH)) then {
				_unitRR_High = _unitRR_Low max (DEFAULT_RR_HIGH + _changeRR_High);
			};
		} else {_unitRR_High = _unitRR_Low max (_unitRR_High + _changeRR_High)};
		SETRR(_unit,[_unitRR_Low, _unitRR_High])

		// 血氧
		private _changeSpo2 = _changeValue get "SpO2";
		private _changeSpo2 = (_changeSpo2 # 0 - _changeSpo2 # 1) * _severity;
		private _unitSpo2 = GETSPO2(_unit);

		if((_unitSpo2 - DEFAULT_SPo2) * _changeSpo2 > 0 ) then {
			if(abs _changeSpo2 > abs(_unitSpo2 - DEFAULT_SPo2)) then {
				SETSPO2(_unit,0 max (DEFAULT_SPo2 + _changeSpo2));
			};
		} else {SETSPO2(_unit,0 max (_unitSpo2 + _changeSpo2))};

		// 血液流失
		private _bloodloss = _changeValue get "Bloodloss";
		_bloodloss  = (_bloodloss # 0 - _bloodloss # 1) * _severity;
		private _unitBloodVolume = GETBLOODVOLUME(_unit);
		SETBLOODVOLUME(_unit,_unitBloodVolume - _bloodloss);

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

		}forEach _reduceSymptom;
		_x set [4, _reduceSymptom];

		// 症状独立函数
		private _symptomData = [_unit, _symptomClass, _hitPart, _severity];
		{
			private _returnValue = _symptomData call _x;

			if (toLower(_returnValue) isEqualType "exit") then {break};
		} forEach _symptomHandlers;
		
	}forEach _symptomInfo;
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;