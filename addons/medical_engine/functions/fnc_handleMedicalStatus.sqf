#include "script_component.hpp"
params["_unit"];

if (_unit getVariable [QEGVAR(medical,MedicalStatus_PFH), false]) exitWith {};
_unit setVariable [QEGVAR(medical,MedicalStatus_PFH), true];

if (!local _unit) then {
    ["handleMedicalState", [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
	params ["_args", "_idPFH"];
    _args params ["_unit"];
	if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QEGVAR(medical,MedicalStatus_PFH), nil];
    };

	private _unitHR = GETHR(_unit);
	private _unitRR = GETRR(_unit);
	private _unitPain = GETPAIN(_unit);
	private _unitSpo2 = GETSPO2(_unit);
	
	private _unitHR_Target = GETHR_T(_unit);
	private _unitRR_Target = GETRR_T(_unit);
	private _unitPain_Target = GETPAIN_T(_unit);
	private _unitSpo2_Target = GETSPO2_T(_unit);

}, 2, [_unit]] call CBA_fnc_addPerFrameHandler;