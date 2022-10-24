#include "script_component.hpp"
params ["_typeOfProjectile"];

private _typeOfSymptoms = EGVAR(meidical,symptomTypeCache) get _typeOfProjectile;

if (isNil "_typeOfSymptoms") then {
    if (isText (configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_SymptomsType")) then {
        _typeOfSymptoms = getText (configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_SymptomsType");
    } else {
        _typeOfSymptoms = "unknown";
    };

    // config may define an invalid damage type
    if !(_typeOfSymptoms in EGVAR(meidical,symptomsDetails)) then {
        _typeOfSymptoms = [["unknown", 0]];
    };

    EGVAR(meidical,symptomTypeCache) set [_typeOfProjectile, _typeOfSymptoms];
};

_typeOfSymptoms // return
