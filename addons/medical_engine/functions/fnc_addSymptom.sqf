#include "script_component.hpp"
params ["_unit", "_symptomClass", "_addPart", "_severityInfo"];
_severityInfo params ["_type", "_severity"];

private _symptomInfo = _unit getVariable [QEGVAR(medical,symptomInfo),[]];
private _symptomIndex = _symptomInfo findIf {_x # 0 isEqualTo _symptomClass && _x # 1 isEqualTo _addPart};

EGVAR(meidical,symptomsDetails) get _symptomClass params [
	"", "",
	"_selections",
	"_maxSeverity"
];

if(_symptomIndex != -1) then {
	private _oldSeverity = _symptomInfo # _symptomIndex # 2;
	if(isNil "_oldEfficiency") then {_oldEfficiency = 0};
	
	if((toLower _type) isEqualTo "set") then {_severity = 0 max (_severity) min _maxSeverity};
	if((toLower _type) isEqualTo "add") then {_severity = 0 max (_severity + _oldSeverity) min _maxSeverity};

	_symptomInfo set [_symptomIndex, [_symptomClass, _addPart, _severity]];
} else {
	_severity = 0 max (_severity) min _maxSeverity;

	_symptomInfo pushBack [_symptomClass, _addPart, _severity];
};

_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];
[_symptomClass, _addPart, _severity];