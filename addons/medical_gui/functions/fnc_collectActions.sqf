#include "script_component.hpp"

GVAR(actions) = [];

{
    private _entry = _x;
    private _configName = configName _entry;
    private _displayName = GET_STRING(_entry >> "displayName",_configName);
    private _category = GET_STRING(_entry >> "category","Other");
    private _condition = compile GET_STRING(_entry >> "condition","");
    private _statement = compile GET_STRING(_entry >> "statement","");

    GVAR(actions) pushBack [_displayName, _category, _condition, _statement];
} forEach configProperties [configFile >> "Neuro_Medical_Treatment_Actions", "isClass _x"];
