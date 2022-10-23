#include "script_component.hpp"
params ["_unit", "_allDamages", "_typeOfDamage"];

if !(_typeOfDamage in GVAR(symptomsDetails)) then {
    _typeOfDamage = "unknown";
};