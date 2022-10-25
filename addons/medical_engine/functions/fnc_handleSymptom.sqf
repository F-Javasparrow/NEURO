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

		EGVAR(meidical,symptomsDetails) get _symptomClass params [
			"_selections",
			"_visableLevel", "_visableValue",
			"_causeSymptom_Hash", "_reduceSymptom_Hash",
			"_changeValue",
			"_symptomHandlers"
		];

		if(isNil "_causeSymptom") then {
			_causeSymptom = _causeSymptom_Hash;
			_x set [3, _causeSymptom];
		};
		if(isNil "_reduceSymptom") then {
			_reduceSymptom = _reduceSymptom_Hash;
			_x set [4, _causeSymptom];
		};

		// 应用心率&血压&血氧的直接改变
		private _type = _changeValue get "TYPE";
		private _changeHR = _changeValue get "HR";
		private _changeRR = _changeValue get "RR";
		private _changeSpo2 = _changeValue get "SPO2";

		private _unitHR = GETHR(_unit);
		private _unitRR = GETRR(_unit);
		private _unitSpo2 = GETSPO2(_unit);
		SETHR(_unit,(0 max (_unitHR+_changeHR)));
		SETHR(_unit,(0 max (_unitRR+_changeRR)));
		SETHR(_unit,(0 max (_unitSpo2+_changeSpo2)));

		// 特殊类型处理
		switch(_type) do {
			case"Wound": {
				
			};
			case"Symptom": {

			};
		};

		// 导致&减少
		{
			_x params ["_causeSymptomClass", "_threshold", "_type", "_value", ["_repeat", false]];

			if(_threshold # 0 <= _severity && _severity < _threshold # 1) then {
				if(typeName _repeat == "BOOL" || !_repeat) then {
					_causeSymptom deleteAt _forEachIndex;
				};
				if(typeName _repeat == "SCALAR" || _repeat <= 0) then {
					_causeSymptom deleteAt _forEachIndex;
				} else {
					_repeat = _repeat - 1;
				};

				[QEGVAR(medical,addSymptom), [_unit, _syptomsClass, _hitPart, [_type, _value]]] call CBA_fnc_localEvent;
			};
		}forEach _causeSymptom;
		{
			// toDo

		}forEach _reduceSymptom

		// 症状独立函数
		private _symptomData = [_unit, _hitPart, _severity];
		{
			_returnValue = _symptomData call _x;

			if (toLower _returnValue isEqualType "exit") exitWith {};
		} forEach _symptomHandlers;
		
	}forEach _symptomInfo;
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;