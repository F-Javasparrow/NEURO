#include "script_component.hpp"
params["_unit", "_medicationClass","_efficiency","_addPart"];

private _medicationInfo = _unit getVariable [QEGVAR(medical,medicationInfo),[]];
private _medicationIndex = _medicationInfo findIf {_x # 0 isEqualTo _medicationClass && _x # 1 isEqualTo _addPart};

if(_medicationIndex != -1) then {
	private _oldEfficiency = _medicationInfo # _medicationIndex # 2;
	if(isNil "_oldEfficiency") then {_oldEfficiency = 0};
	_efficiency = 0 max (_efficiency + _oldEfficiency) min 1;

	_medicationInfo set [_medicationIndex, [_medicationClass, _addPart, _efficiency]];
} else {
	_efficiency = 0 max (_efficiency) min 1;

	_medicationInfo pushBack [_medicationClass, _addPart, _efficiency];
};

_unit setVariable [QEGVAR(medical,medicationInfo), _medicationInfo];
[_medicationClass, _addPart, _efficiency];