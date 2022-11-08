#include "script_component.hpp"
params ["_display"];

[{
    [{setMousePosition _this}, _this] call CBA_fnc_execNextFrame;
}, getMousePosition] call CBA_fnc_execNextFrame;

uiNamespace setVariable [QGVAR(menuDisplay), _display];
["neuro_medicalMenuOpened", [(call CBA_fnc_currentUnit), GVAR(target), _display]] call CBA_fnc_localEvent;

if (GVAR(menuPFH) != -1) exitWith {};
GVAR(menuPFH) = [{
    private _entries = [];
    private _unit = GVAR(target);
    if(isNil "_unit") then {_unit = call CBA_fnc_currentUnit};

    private _display = uiNamespace getVariable [QGVAR(menuDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _selectedCategory = lbCurSel IDC_Category;
    private _selectedCategory = lbText [IDC_Category, _selectedCategory];
    
    // 动作-------------------------------------------------------------- //
    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
        _ctrl ctrlShow false;
    } forEach IDCS_ACTION_BUTTONS;

    private _idcIndex = 0;
    {
        _x params ["_displayName", "_category", "_condition", "_statement"];

        if (_category == _selectedCategory && {call _condition}) then {
            private _ctrl = _display displayCtrl (IDCS_ACTION_BUTTONS select _idcIndex);
            _ctrl ctrlSetText _displayName;
            _ctrl ctrlShow true;

            _ctrl ctrlAddEventHandler ["ButtonClick",_statement];

            _idcIndex = _idcIndex + 1;
        };
    } forEach GVAR(actions);

    // 部位-------------------------------------------------------------- //
    private _mainPartName = [//--- ToDo: Localize;
        "# "+"头部",
        "# "+"躯干",
        "# "+"腹部",
        "# "+"左手",
        "# "+"右手",
        "# "+"左腿",
        "# "+"右腿"
    ] select GVAR(selectedMainPart_Index);
    _entries pushBack ["", _mainPartName, [1,1,1,1], "", [1,1,1,1]];

    // 症状 & 药物------------------------------------------------------- //
    private _ctrlSyptoms = _display displayCtrl IDC_SYPTOMS;
    private _ctrlSyptomSeverity = _display displayCtrl IDC_SEVERITY;
    //private _ctrlSyptomsPic = _display displayCtrl IDC_SYPTOMSPIC;
    GVAR(selectedMainPart) = GVAR(Inedx2MainPart) get GVAR(selectedMainPart_Index);

    private _symptomInfo = _unit getVariable[QEGVAR(medical,symptomInfo),[]];
    private _medicationInfo = _unit getVariable[QEGVAR(medical,medicationInfo),[]];
    private _medicLevel = player getVariable[QEGVAR(medical,medicLevel),0];

    if(_symptomInfo isEqualTo [] && _medicationInfo isEqualTo []) then {
        _entries pushBack ["", "无症状", [1,1,1,1], "", [1,1,1,1]];//--- ToDo: Localize;
    } else {
        {
            _x params ["_symptomClass", "_hitPartInfo", "_severity"];
            _hitPartInfo params ["_mainHitPart", "_subHitPart"];

            EGVAR(meidical,symptomsDetails) get _symptomClass params [
                "_displayName", "_displayDesc",
                "_selections",
                "_maxSeverity",
                "_visableLevel", "_visableValue"
            ];

            private _picPath = "";
            if(isClass (configFile >> "Neuro_Medical_Symptoms" >> _symptomClass)) then {
                _picPath = GET_STRING(configFile >> "Neuro_Medical_Symptoms" >> _symptomClass >> "displayPic","");
            };

            if(_severity > _visableValue#0 && _severity <= _visableValue #1 && _visableLevel <= _medicLevel && _mainHitPart isEqualTo GVAR(selectedMainPart)) then { 
                _entries pushBack [_picPath, _displayName, [1,1,1,1], str (ceil (_severity * 10000) / 100) + "%", [1,1,1,1]];
            };
        }forEach _symptomInfo;

        {
            _x params ["_medicationClass", "_hitPartInfo", "_severity"];

            EGVAR(meidical,medicationDetails) get _medicationClass params [
			    "_displayName", "_displayDesc",
			    "_selections"
		    ];

            _entries pushBack ["", _displayName, [1,1,1,1], str (ceil (_severity * 10000) / 100) + "%", [1,1,1,1]];
        }forEach _medicationInfo;
    };

    lbClear _ctrlSyptoms;
    lbClear _ctrlSyptomSeverity;
    {
        _x params ["_picPath", "_textSyptoms", "_colorSyptoms", "_textSeverity", "_colorSeverity"];

        private _index = _ctrlSyptoms lbAdd _textSyptoms;
        _ctrlSyptoms lbSetColor [_index, _colorSyptoms];

        if!(_picPath isEqualTo "") then {
            _ctrlSyptoms lbSetPicture [_index, _picPath];
            _ctrlSyptoms lbSetPictureColor [_index, [1,1,1,1]];
        } else {
            _ctrlSyptoms lbSetPictureColor [_index, [1,1,1,0]];
        };

        private _index = _ctrlSyptomSeverity lbAdd _textSeverity;
        _ctrlSyptomSeverity lbSetColor [_index, _colorSeverity];
    } forEach _entries;
    _ctrlSyptoms lbSetCurSel -1;
    _ctrlSyptomSeverity lbSetCurSel -1;

    // 监视器------------------------------------------------------------- //
    private _ctrlMonitorHR = _display displayCtrl IDC_MONITOR_HR;
    private _ctrlMonitorRR = _display displayCtrl IDC_MONITOR_RR;
    private _ctrlMonitorSpO2 = _display displayCtrl IDC_MONITOR_SPO2;

    private _unitHR = GETHR(_unit);
	private _unitRR = GETRR(_unit);
	private _unitSpo2 = GETSPO2(_unit);

    ctrlSetText [IDC_MONITOR_HR, "HR:" + str(ceil (_unitHR*10)/10)];
    ctrlSetText [IDC_MONITOR_RR, "RR:" + str(ceil (_unitRR # 0)) + "/" + str(ceil (_unitRR # 1))];
    ctrlSetText [IDC_MONITOR_SPO2, "SpO2:" + str(ceil (_unitSpo2*10)/10) + "%"];

    _ctrlMonitorHR ctrlSetTextColor [1, 0, 0, 1];
    _ctrlMonitorRR ctrlSetTextColor [0, 1, 0, 1];
    _ctrlMonitorSpO2 ctrlSetTextColor [0, 0, 1, 1];

    // ------------------------------------------------------------------ //

}, 0, []] call CBA_fnc_addPerFrameHandler;
