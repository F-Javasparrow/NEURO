#include "script_component.hpp"
params ["_unit", "_allDamages", "_shooter", "_ammo"];

private _typeOfDamage = _ammo call FUNC(getTypeOfDamage);
if (_typeOfDamage in GVAR(symptomsDetails)) then {
    (GVAR(damageTypeDetails) get _typeOfDamage) params ["", "", "_woundHandlers"];
    
    private _damageData = [_unit, _allDamages, _typeOfDamage];
    {
        _damageData = _damageData call _x;

        if !(_damageData isEqualType []) exitWith {};
    } forEach _woundHandlers;
    
};
