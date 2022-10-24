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
		_x params ["_symptomClass", "_hitPart", "_severity"];
		_hitPart params ["_mainPart", "_subPart"];

		EGVAR(meidical,symptomsDetails) get _symptomClass params [
			"_selections",
			"_visableLevel", "_visableValue",
			"_causeSymptom", "_reduceSymptom",
			"_changeValue",
			"_symptomHandlers"
		];

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

		switch(_type) do {
			case"Wound": {
				
			};
			case"Symptom": {

			};
		};

		private _symptomData = [_unit, _hitPart, _severity];
		{
			_returnValue = _symptomData call _x;

			if (toLower _returnValue isEqualType "exit") exitWith {};
		} forEach _symptomHandlers;
		
	}forEach _symptomInfo;
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;