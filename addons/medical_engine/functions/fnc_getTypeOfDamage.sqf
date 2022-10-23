#include "script_component.hpp"
params ["_typeOfProjectile"];

private _woundType = GVAR(damageTypeCache) get _typeOfProjectile;

if (isNil "_woundType") then {
    if (isText (configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_woundType")) then {
        _woundType = getText (configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_woundType");
    } else {
        _woundType = "unknown";
    };

    // config may define an invalid damage type
    if !(_woundType in GVAR(damageTypeDetails)) then {
        _woundType = "unknown";
    };

    GVAR(damageTypeCache) set [_typeOfProjectile, _woundType];
};

_woundType // return
