#include "script_component.hpp"

// --- parse Symptoms
GVAR(symptomTypeCache) = createHashMap;
GVAR(symptomsDetails) = createHashMap;

private _symptomConfig = configFile >> "Neuro_Medical_Symptoms";

{
    private _entry = _x;
    private _className = configName _entry;

    if (_className == "symptomHandlers") then {continue};

    GVAR(symptomTypeCache) set [_className, _className];
    GVAR(symptomTypeCache) set ["#"+_className, _className];

    // -------------------------------------------------------------------------------- //

    private _selections = GET_ARRAY(_entry >> "selections",ALL_MAINBODYPART);
    private _visableLevel = GET_NUMBER(_entry >> "visableLevel",0);
    private _visableValue = GET_ARRAY(_entry >> "visableValue",[0,100]);

    private _causeSymptom = GET_ARRAY(_entry >> "causeSymptom",[]);
    private _reduceSymptom = GET_ARRAY(_entry >> "reduceSymptom",[])

    // -------------------------------------------------------------------------------- //

    private _subEntry = _entry >> "details";
    private _changeValue = createHashMap;

    _changeValue set ["TYPE", GET_STRING(_subEntry >> "type","unknown")];
    
    _changeValue set ["HR", GET_ARRAY(_subEntry >> "changeHR",[0,0,0])];
    _changeValue set ["RR", GET_ARRAY(_subEntry >> "changeRR",[0,0,0])];
    _changeValue set ["PAIN", GET_ARRAY(_subEntry >> "changePain",[0,0,0])];
    _changeValue set ["SPO2", GET_ARRAY(_subEntry >> "changeSPo2",[0,0,0])];

    // -------------------------------------------------------------------------------- //

    _changeValue set ["BLOODLOSING", GET_ARRAY(_subEntry >> "bloodLosing",nil)];
    _changeValue set ["MUTILATE", GET_NUMBER(_subEntry >> "mutilate",nil)];

    // -------------------------------------------------------------------------------- //

    private _symptomHandlers = [];
    if (isClass (_entry >> "symptomHandlers")) then {
        _symptomHandlers = [_entry >> "symptomHandlers"] call FUNC(parseHandlersCfg);
        reverse _symptomHandlers;
    };

    // -------------------------------------------------------------------------------- //

    private _details = [_selections, _visableLevel, _visableValue, _causeSymptom, _reduceSymptom, _changeValue, _symptomHandlers];
    GVAR(symptomsDetails) set [_className, _details];

} forEach configProperties [_symptomConfig, "isClass _x"];

// --- parse DamageType
GVAR(damageTypeDetails) = createHashMap;
GVAR(damageTypeCache) = createHashMap;

private _damageTypesConfig = configFile >> "Neuro_Medical_DamageWound";

private _defaultWoundHandlers = [];
if (isClass (_damageTypesConfig >> "woundHandlers")) then {
    _defaultWoundHandlers = [_damageTypesConfig >> "woundHandlers"] call FUNC(parseHandlersCfg);
    reverse _defaultWoundHandlers;
};

{
    private _entry = _x;
    private _className = configName _entry;

    if (_className == "woundHandlers") then {continue};

    GVAR(damageTypeCache) set [_className, _className];
    GVAR(damageTypeCache) set ["#"+_className, _className];

    private _wound = GET_ARRAY(_entry >> "woundChance",[["unknow", 0, 0]]);
    private _selection = GET_NUMBER(_entry >> "selection",ALL_MAINBODYPART);

    private _woundHandlers = [];
    if (isClass (_entry >> "woundHandlers")) then {
        _woundHandlers = [_entry >> "woundHandlers"] call FUNC(parseWoundHandlersCfg);
        reverse _woundHandlers;
    } else {
        _woundHandlers = _defaultWoundHandlers;
    };

    GVAR(damageTypeDetails) set [_className, [_wound, _selection, _woundHandlers]];

}forEach configProperties [_damageTypesConfig, "isClass _x"];