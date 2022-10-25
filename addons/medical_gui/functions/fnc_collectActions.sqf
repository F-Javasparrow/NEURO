#include "script_component.hpp"

GVAR(actions) = [];

{
    private _configName = configName _x;
    private _displayName = getText (_x >> "displayName");
    private _category = getText (_x >> "category");
    private _condition = compile format [QUOTE([ARR_4(ACE_player, GVAR(target), %1 select GVAR(selectedBodyPart), '%2')] call DEFUNC(medical_treatment,canTreatCached)), ALL_BODY_PARTS, _configName];
    private _statement = compile format [QUOTE([ARR_4(ACE_player, GVAR(target), %1 select GVAR(selectedBodyPart), '%2')] call DEFUNC(medical_treatment,treatment)), ALL_BODY_PARTS, _configName];

    GVAR(actions) pushBack [_displayName, _category, _condition, _statement];
} forEach configProperties [configFile >> QEGVAR(medical_treatment,actions), "isClass _x"];
