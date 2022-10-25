#include "script_component.hpp"

// --- parse Symptoms
EGVAR(meidical,symptomTypeCache) = createHashMap;
EGVAR(meidical,symptomsDetails) = createHashMap;

private _symptomConfig = configFile >> "Neuro_Medical_Symptoms";

{
    private _entry = _x;
    private _className = configName _entry;

    if (_className == "symptomHandlers") then {continue};

    EGVAR(meidical,symptomTypeCache) set [_className, _className];
    EGVAR(meidical,symptomsDetails) set ["#"+_className, _className];

    // -------------------------------------------------------------------------------- //
    private _displayName = GET_STRING(_entry >> "displayName","Null Name");
    private _displayDesc = GET_STRING(_entry >> "displayDesc","Null Desc");

    private _selections = GET_ARRAY(_entry >> "selections",ALL_MAINBODYPART);
    private _visableLevel = GET_NUMBER(_entry >> "visableLevel",0);
    private _visableValue = GET_ARRAY(_entry >> "visableValue",[ARR_2(0,100)]);

    private _causeSymptom = GET_ARRAY(_entry >> "causeSymptom",[]);
    private _reduceSymptom = GET_ARRAY(_entry >> "reduceSymptom",[])

    // -------------------------------------------------------------------------------- //

    private _changeValue = createHashMap;

    _changeValue set ["TYPE", GET_STRING(_entry >> "details" >> "type","unknown")];
    
    _changeValue set ["HR", GET_ARRAY(_entry >> "details" >> "changeHR",[ARR_3(0,0,0)])];
    _changeValue set ["RR", GET_ARRAY(_entry >> "details" >> "changeRR",[ARR_3(0,0,0)])];
    _changeValue set ["SPO2", GET_ARRAY(_entry >> "details" >> "changeSPo2",[ARR_3(0,0,0)])];

    // -------------------------------------------------------------------------------- //

    _changeValue set ["BLOODLOSING", GET_ARRAY(_entry >> "details" >> "bloodLosing",nil)];
    _changeValue set ["MUTILATE", GET_NUMBER(_entry >> "details" >> "mutilate",nil)];

    // -------------------------------------------------------------------------------- //

    private _symptomHandlers = [];
    if (isClass (_entry >> "symptomHandlers")) then {
        _symptomHandlers = [_entry >> "symptomHandlers"] call FUNC(parseHandlersCfg);
        reverse _symptomHandlers;
    };

    // -------------------------------------------------------------------------------- //

    private _details = [_displayName, _displayDesc, _selections, _visableLevel, _visableValue, _causeSymptom, _reduceSymptom, _changeValue, _symptomHandlers];
    EGVAR(meidical,symptomsDetails) set [_className, _details];

} forEach configProperties [_symptomConfig, "isClass _x"];