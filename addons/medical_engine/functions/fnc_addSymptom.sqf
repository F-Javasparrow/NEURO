#include "script_component.hpp"
params ["_unit", "_symptomClass", "_hitPartInfo", "_severityInfo"];
_hitPartInfo params ["_mainHitPart", "_subHitPart"];
_severityInfo params ["_adjustType", "_severity"];

private _symptomInfo = _unit getVariable [QEGVAR(medical,symptomInfo),[]];

_symptomIndex = _symptomInfo findIf {_x # 0 == _symptomClass && _x # 1 == _hitPartInfo};

if(_symptomIndex != -1) then {
	_oldSeverity = _symptomInfo # _symptomIndex # 2;
	if((toLower _adjustType) isEqualTo "set") then {_severity = 0 max (_severity) min 100};
	if((toLower _adjustType) isEqualTo "add") then {_severity = 0 max (_severity + _oldSeverity) min 100};

	_symptomInfo set [_symptomIndex, [_symptomClass, _hitPartInfo, _severity]];
} else {
	_severity = 0 max (_severity) min 100;

	_symptomInfo pushBack [_symptomClass, _hitPartInfo, _severity];
};

_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];

[_symptomClass, _hitPartInfo, _severity];