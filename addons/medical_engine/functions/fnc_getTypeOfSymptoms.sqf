#include "script_component.hpp"
params ["_typeOfProjectile"];

private _woundOfDamage = EGVAR(meidical,woundOfDamage) get _typeOfProjectile;
private _woundList = [];
if (isNil "_woundOfDamage") then {

    _woundOfDamage = GET_ARRAY(configFile >> "CfgAmmo" >> _typeOfProjectile >> "Neuro_woundOfDamage",[[ARR_2("unknown",0)]]);

    
    {
        if(_forEachIndex % 2 == 0) then {
            _woundList pushBack [_x, _woundOfDamage # (_forEachIndex + 1)];
        };  
    } forEach _woundOfDamage;

    EGVAR(meidical,woundOfDamage) set [_typeOfProjectile, _woundOfDamage2];
};

_woundList;
