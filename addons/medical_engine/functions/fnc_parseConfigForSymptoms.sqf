#include "script_component.hpp"

// --- parse Symptoms
private _symptomConfig = configFile >> "Neuro_Medical_Symptoms";

{
    private _entry = _x;
    private _className = configName _entry;

    if (_className isEqualTo "symptomHandlers") then {continue};

    EGVAR(meidical,symptomTypeCache) set [_className, _className];

    // -------------------------------------------------------------------------------- //
    private _displayName = GET_STRING(_entry >> "displayName","NullName");
    private _displayDesc = GET_STRING(_entry >> "displayDesc","NullDesc");

    private _selections = GET_ARRAY(_entry >> "selections",ALL_MAINBODYPART);
    private _visableLevel = GET_NUMBER(_entry >> "visableLevel",0);
    private _visableValue = GET_ARRAY(_entry >> "visableValue",[ARR_2(0,100)]);

    private _maxSeverity = GET_NUMBER(_entry >> "maxSeverity",1);

    // -------------------------------------------------------------------------------- //

    private _data = createHashMap;
    private _type = GET_STRING(_entry >> "details" >> "type","unknown");
    _data set ["type", _type];
    
    _data set ["changeHR", GET_ARRAY(_entry >> "details" >> "changeHR",[ARR_2(0,0)])];
    _data set ["changeRR", GET_ARRAY(_entry >> "details" >> "changeRR",[ARR_4(0,0,0,0)])];
    _data set ["changeSpO2", GET_ARRAY(_entry >> "details" >> "changeSpO2",[ARR_2(0,0)])];
    _data set ["targetHR", GET_ARRAY(_entry >> "details" >> "targetHR",[ARR_2(0,0)])];
    _data set ["targetRR", GET_ARRAY(_entry >> "details" >> "targetRR",[ARR_4(0,0,0,0)])];
    _data set ["targetSpO2", GET_ARRAY(_entry >> "details" >> "targetSpO2",[ARR_2(0,0)])];

    _data set ["Bloodloss", GET_ARRAY(_entry >> "details" >> "bloodLosing",[ARR_2(0,0)])];

    _data set ["selfReduce", GET_NUMBER(_entry >> "details" >> "selfReduce",0)];

    // -------------------------------------------------------------------------------- //

    private _symptomHandlers = [];
    if (isClass(_entry >> "symptomHandlers")) then {
        _symptomHandlers = [_entry >> "symptomHandlers"] call FUNC(parseHandlersCfg);
        reverse _symptomHandlers;
    };

    // -------------------------------------------------------------------------------- //

    private _causeSymptom = [];
    if(isClass(_entry >> "causeSymptom")) then {
        {
            private _subentry = _x;

            _symptom = configName _subentry;
            _addPart = GET_STRING(_subentry >> "addPart","_SAME_");
            _type = GET_STRING(_subentry >> "addType","add");
            _severityThreshold = GET_NUMBER(_subentry >> "severityThreshold",0);
            _perAdd = GET_NUMBER(_subentry >> "perAdd",0);
            _repeat = GET_NUMBER(_subentry >> "repeat",0);
                
            _causeSymptom pushback [_symptom,_type,_addPart,_severityThreshold,_perAdd/100,_repeat];
        } forEach configProperties [_entry >> "causeSymptom", "isClass _x", false];
    };

    private _reduceSymptom = [];
    if(isClass(_entry >> "reduceSymptom")) then {
        {
            private _subentry = _x;

            _symptom = configName _subentry;
            _addPart = GET_ARRAY(_subentry >> "addPart",["_SAME_"]);
            _type = GET_STRING(_subentry >> "type","add");
            _severityThreshold = GET_NUMBER(_subentry >> "severityThreshold",0);
            _perAdd = GET_NUMBER(_subentry >> "perAdd",0);
            _repeat = GET_NUMBER(_subentry >> "repeat",0);
                
            _reduceSymptom pushback [_symptom,_type,_addPart,_severityThreshold,_perAdd,_repeat];
        } forEach configProperties [_entry >> "reduceSymptom", "isClass _x", false];
    };

    // -------------------------------------------------------------------------------- //

    EGVAR(meidical,symptomsDetails) set [_className, [_displayName, _displayDesc, _selections, _maxSeverity, _visableLevel, _visableValue, _causeSymptom, _reduceSymptom, _data, _symptomHandlers]];

} forEach configProperties [_symptomConfig, "isClass _x"];