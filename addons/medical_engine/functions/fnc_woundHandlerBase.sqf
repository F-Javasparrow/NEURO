#include "script_component.hpp"
params ["_unit", "_allDamages", "_typeOfDamage"];

if !(_typeOfDamage in GVAR(damageTypeDetails)) then {
    _typeOfDamage = "unknown";
};

GVAR(damageTypeDetails) get _typeOfDamage params ["_wound", "_selection"];

{
    _x params ["_damages","_hitPart"];
    _hitPart params ["_mainHitPart", "_subHitPart"];

    if (_mainHitPart == "#structural") then {continue};

    private _addWoundList = [];
    {
        _x params ["_woundClass", "_chance", "_severity"];

        GVAR(symptomsDetails) get _woundClass params ["_selections"];

        private _worstDamage = 2;
        #define LARGE_WOUND_THRESHOLD 0.5
        private _woundSeverity = linearConversion [0.1, _worstDamage, _damages * _severity, LARGE_WOUND_THRESHOLD^3, 1, true];

        if(_mainHitPart in _selections) then {
            [QEGVAR(medical,addSymptom), [_unit, _woundClass, _hitPart, ["add", _woundSeverity]]] call CBA_fnc_localEvent;
        };
    }forEach _wound;
}forEach _allDamages;

[];
