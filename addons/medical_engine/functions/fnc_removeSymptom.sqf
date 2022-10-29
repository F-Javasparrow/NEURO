#include "script_component.hpp"
params ["_unit", "_SymptomClass", "_mainPart", "_severityInfo"];
_severityInfo params ["_type", "_severity"];

private _symptomInfo = _unit getVariable [QEGVAR(medical,symptomInfo),[]];
private _symptomIndex = _symptomInfo findIf {_x # 0 isEqualTo _symptomClass && _x # 1 isEqualTo _mainHitPart};

if(_symptomIndex != -1) then {
	private _oldSeverity = _symptomInfo # _symptomIndex # 2;
	if((toLower _type) isEqualTo "set") then {_severity = 0 max (_severity) min _maxSeverity};
	if((toLower _type) isEqualTo "reduce") then {_severity = 0 max (_severity + _oldSeverity) min _maxSeverity};
	if((toLower _type) isEqualTo "remove") then {_severity = nil};

	if!(isNil "_severity") then {
		_symptomInfo set [_symptomIndex, [_symptomClass, _mainHitPart, _severity]];
	} else {
		_symptomInfo = _symptomInfo deleteAt _symptomIndex;
	};
};

_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];

[_symptomClass, _mainHitPart, _severity];