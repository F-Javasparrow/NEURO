#include "script_component.hpp"
params["_unit"];

if (_unit getVariable [QEGVAR(medical,MedicalStatus_PFH), false]) exitWith {};
_unit setVariable [QEGVAR(medical,MedicalStatus_PFH), true];

if (!local _unit) then {
    ["handleMedicalState", [_unit], _unit] call CBA_fnc_targetEvent;
};

private _deltaT = GVAR(MedicalStatus_PFH_DeltaT);

[{
	params ["_args", "_idPFH"];
    _args params ["_unit", "_deltaT"];
	if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QEGVAR(medical,MedicalStatus_PFH), nil];
    };

	private _unitHR = GETHR(_unit);
	private _unitRR = GETRR(_unit);
	private _unitSpo2 = GETSPO2(_unit);
	
	private _unitHR_Target = GETHR_T(_unit);
	private _unitRR_Target = GETRR_T(_unit);
	private _unitSpo2_Target = GETSPO2_T(_unit);

	private _changedValueList = [];
	{
		_x param ["_value","_targetValue"];

		_changeValue = round(_targetValue - _value) / 2;

		if (_changeValue < 0) then {
        _value = (_value + _deltaT * _changeValue) max _targetHR;
		} else {
			_value = (_value + _deltaT * _changeValue) min _targetHR;
		};

		_changedValueList pushBack _value;
	}forEach [[_unitHR, _unitHR_Target],[_unitRR, _unitRR_Target],[_unitSpo2, _unitSpo2_Target]];

	_unitHR = 0 max (_changedValueList # 0);
	_unitRR = 0 max (_changedValueList # 1);
	_unitSpo2 = 0 max (_changedValueList # 2) min 100;
	
	if(_unitHR <= 0) then {
		
	};

	SETHR(_unit,_unitHR);
	SETRR(_unit,_unitRR);
	SETSPO2(_unit,_unitSpo2);
}, _deltaT, [_unit, _deltaT]] call CBA_fnc_addPerFrameHandler;