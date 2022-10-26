#include "script_component.hpp"
params ["_unit", "_symptomClass", "_hitPartInfo", "_severityInfo"];
_hitPartInfo params ["_mainHitPart", "_subHitPart"];
_severityInfo params ["_adjustType", "_severity"];

private _symptomInfo = _unit getVariable [QEGVAR(medical,symptomInfo),[]];

_symptomIndex = _symptomInfo findIf {_x # 0 isEqualTo _symptomClass && _x # 1 isEqualTo _hitPartInfo};

if(_symptomIndex != -1) then {
	_oldSeverity = _symptomInfo # _symptomIndex # 2;
	if((toLower _adjustType) isEqualTo "set") then {_severity = 0 max (_severity)};
	if((toLower _adjustType) isEqualTo "add") then {_severity = 0 max (_severity + _oldSeverity)};

	_symptomInfo set [_symptomIndex, [_symptomClass, _hitPartInfo, _severity]];
} else {
	_severity = 0 max (_severity);

	_symptomInfo pushBack [_symptomClass, _hitPartInfo, _severity];
};

_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];
hint str [_symptomClass, _hitPartInfo, _severity];
[_symptomClass, _hitPartInfo, _severity];