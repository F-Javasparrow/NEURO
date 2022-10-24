#include "script_component.hpp"
params ["_typeOfProjectile"];

private _typeOfSymptoms = GVAR(SymptomsTypeCache) get _typeOfProjectile;

if (isNil "_typeOfSymptoms") then {
    if (isText (configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_SymptomsType")) then {
        _typeOfSymptoms = getText (configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_SymptomsType");
    } else {
        _typeOfSymptoms = "unknown";
    };

    // config may define an invalid damage type
    if !(_typeOfSymptoms in GVAR(symptomsDetails)) then {
        _typeOfSymptoms = [["unknown", 0]];
    };

    GVAR(SymptomsTypeCache) set [_typeOfProjectile, _typeOfSymptoms];
};

_typeOfSymptoms // return
