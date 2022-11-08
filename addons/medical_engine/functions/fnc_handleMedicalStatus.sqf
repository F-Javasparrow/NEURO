#include "script_component.hpp"
params["_unit"];

if (_unit getVariable [QEGVAR(medical,MedicalStatus_PFH), false]) exitWith {};
_unit setVariable [QEGVAR(medical,MedicalStatus_PFH), true];

if (!local _unit) then {
    ["handleMedicalState", [_unit], _unit] call CBA_fnc_targetEvent;
};

private _deltaT = GVAR(MedicalStatus_PFH_DeltaT);
_deltaT = 1;

[{
	params ["_args", "_idPFH"];
    _args params ["_unit", "_deltaT"];
	if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QEGVAR(medical,MedicalStatus_PFH), nil];
    };

	// 心率
	private _unitHR = GETHR(_unit);
	private _unitHR_Target = GETHR_T(_unit);
	
	_changeValue = round(_unitHR_Target - _unitHR) / 2;
	if (_changeValue < 0) then {
    	_unitHR = (_unitHR + (_deltaT * _changeValue)) max _unitHR_Target;
	} else {
		_unitHR = (_unitHR + (_deltaT * _changeValue)) min _unitHR_Target;
	};

	// 血压
	private _unitRR = GETRR(_unit);
	private _unitRR_Low = _unitRR # 0;
	private _unitRR_High = _unitRR # 1;
	private _unitRR_Target = GETRR_T(_unit);
	private _unitRR_Low_Target = _unitRR_Target # 0;
	private _unitRR_High_Target = _unitRR_Target # 1;

	_changeValue = round(_unitRR_Low_Target - _unitRR_Low) / 2;
	if (_changeValue < 0) then {
    	_unitRR_Low = (_unitRR_Low + (_deltaT * _changeValue)) max _unitRR_Low_Target;
	} else {
		_unitRR_Low = (_unitRR_Low + (_deltaT * _changeValue)) min _unitRR_Low_Target;
	};
	
	_changeValue = round(_unitRR_High_Target - _unitRR_High) / 2;
	if (_changeValue < 0) then {
    	_unitRR_High = (_unitRR_High + (_deltaT * _changeValue)) max _unitRR_High_Target;
	} else {
		_unitRR_High = (_unitRR_High + (_deltaT * _changeValue)) min _unitRR_High_Target;
	};

	// 血氧
	private _unitSpO2 = GETSPO2(_unit);
	private _unitSpO2_Target = GETSPO2_T(_unit);
	_changeValue = round(_unitSpO2_Target - _unitSpO2) / 2;
	if (_changeValue < 0) then {
    	_unitSpO2 = (_unitSpO2 + (_deltaT * _changeValue)) max _unitSpO2_Target;
	} else {
		_unitSpO2 = (_unitSpO2 + (_deltaT * _changeValue)) min _unitSpO2_Target;
	};

	[_unit] call FUNC(TriggerSymptom);
	[_unit] call FUNC(updatingMedicLevel);

	SETHR(_unit,_unitHR);
	SETRR(_unit,[ARR_2(_unitRR_Low,_unitRR_High)]);
	SETSPO2(_unit,_unitSpO2);
}, _deltaT, [_unit, _deltaT]] call CBA_fnc_addPerFrameHandler;