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

		GVAR(symptomsDetails) get _symptomClass params [
			"_selections",
			"_visableLevel", "_visableValue",
			"_causeSymptom", "_reduceSymptom",
			"_changeValue",
			"_symptomHandlers"
		];

		private _type = _changeValue get "TYPE";
		private _changeHR = random (_changeValue get "HR");
		private _changeRR = random (_changeValue get "RR");
		private _changePain = random (_changeValue get "PAIN");
		private _changeSPo2 = random (_changeValue get "SPO2");

		switch(_type) do {
			case"Wound": {
				private _mutilate = _changeValue get "MUTILATE";
			};
			case"Symptom": {

			};
		};
	}forEach _symptomInfo;
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;