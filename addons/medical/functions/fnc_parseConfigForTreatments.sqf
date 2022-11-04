#include "script_component.hpp"

// --- parse medications
EGVAR(meidical,medicationTypeCache) = createHashMap;
EGVAR(meidical,medicationDetails) = createHashMap;

private _medicationConfig = configFile >> "Neuro_Medical_Treatments";

{
    private _entry = _x;
    private _className = configName _entry;

    if (_className isEqualTo "treatmentHandlers") then {continue};

    EGVAR(meidical,medicationTypeCache) set [_className, _className];
    EGVAR(meidical,medicationDetails) set [_className, _className];

    // -------------------------------------------------------------------------------- //

    private _displayName = GET_STRING(_entry >> "displayName","NullName");
    private _displayDesc = GET_STRING(_entry >> "displayDesc","NullDesc");

    private _selections = GET_ARRAY(_entry >> "selections",ALL_MAINBODYPART);
    private _timeInSystem = GET_ARRAY(_entry >> "timeInSystem",[ARR_2(10,600)]);
    private _efficiency = GET_NUMBER(_entry >> "efficiency",0.2);

    private _data = createHashMap;
    private _type = GET_STRING(_entry >> "details" >> "type","unknown");
    _data set ["type", _type];

    _data set ["changeHR", GET_ARRAY(_entry >> "details" >> "changeHR",[ARR_2(0,0)])];
    _data set ["changeRR", GET_ARRAY(_entry >> "details" >> "changeRR",[ARR_4(0,0,0,0)])];
    _data set ["changeSpO2", GET_ARRAY(_entry >> "details" >> "changeSpO2",[ARR_2(0,0)])];
    _data set ["changeViscosity", GET_ARRAY(_entry >> "details" >> "changeViscosity",[ARR_2(0,0)])];

    _data set ["selfReduce", GET_NUMBER(_entry >> "details" >> "selfReduce",0)];

    // -------------------------------------------------------------------------------- //

    private _medicationHandlers = [];
    if (isClass(_entry >> "medicationHandlers")) then {
        _medicationHandlers = [_entry >> "medicationHandlers"] call EFUNC(medical_engine,parseHandlersCfg);
        reverse _medicationHandlers;
    };

    // -------------------------------------------------------------------------------- //

    private _causeSymptom = [];
    if(isClass(_entry >> "causeSymptom")) then {
        {
            private _subentry = _x;

            _symptom = configName _subentry;
            _addPart = GET_STRING(_subentry >> "addPart","_SAME_");
            _type = GET_STRING(_subentry >> "type","add");
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

    EGVAR(meidical,medicationDetails) set [_className, [_displayName, _displayDesc, _selections, _timeInSystem, _efficiency, _causeSymptom, _reduceSymptom, _data, _medicationHandlers]];

} forEach configProperties [_medicationConfig, "isClass _x"];