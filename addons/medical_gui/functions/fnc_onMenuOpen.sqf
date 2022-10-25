#include "script_component.hpp"
params ["_display"];

hint "opened Menu";

[{
    [{setMousePosition _this}, _this] call CBA_fnc_execNextFrame;
}, getMousePosition] call CBA_fnc_execNextFrame;

uiNamespace setVariable [QGVAR(menuDisplay), _display];
["neuro_medicalMenuOpened", [(call CBA_fnc_currentUnit), GVAR(target), _display]] call CBA_fnc_localEvent;

if (GVAR(menuPFH) != -1) exitWith {};

GVAR(menuPFH) = [{

    private _display = uiNamespace getVariable [QGVAR(menuDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _selectedCategory = lbCurSel IDC_Category;
    systemChat str[_selectedCategory];
    
    // ------------------------------------------------------------------ //
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

            _ctrl ctrlAddEventHandler ["ButtonClick", _statement];
            _ctrl ctrlAddEventHandler ["ButtonClick", {GVAR(pendingReopen) = true}];

            _idcIndex = _idcIndex + 1;
        };
    } forEach GVAR(actions);

    // ------------------------------------------------------------------ //
    private _ctrlSyptoms = _display displayCtrl IDC_SYPTOMS;

    private _selectedMainPart = GVAR(Inedx2MainPart) get _selectedCategory;
    private _symptomInfo = GVAR(target) getVariable [QEGVAR(medical,symptomInfo),[]];
    
    private _mainPartName = [//--- ToDo: Localize;
        "头部",
        "躯干",
        "腹部",
        "左手",
        "右手",
        "左腿",
        "右腿"
    ] select _selectedCategory;
    _entries pushBack [_mainPartName, [1, 1, 1, 1]];

    {
        _x params ["_symptomClass", "_hitPartInfo", "_severity"];
        _hitPartInfo params ["_mainHitPart", "_subHitPart"];

        EGVAR(meidical,symptomsDetails) get _symptomClass params [
            "_displayName", "_displayDesc",
			"_selections",
			"_visableLevel", "_visableValue",
			"", "",
			"",
			""
		];

        if(_severity >= _visableValue#0 && _severity <= _visableValue#1 && _mainHitPart == _selectedMainPart) then {
            _symptomEntries pushBack [format ["%1", _displayName], [1, 1, 1, 1]];
        };
    }forEach _symptomInfo;

    if (_symptomEntries isEqualTo []) then {
        _entries pushBack ["无症状", [1, 1, 1, 1]];
    } else {
        _entries append _symptomEntries;
    };

    lbClear _ctrlSyptoms;
    {
        _x params ["_text", "_color"];

        _ctrlSyptoms lbSetColor [_ctrlSyptoms lbAdd _text, _color];
    } forEach _entries;

    _ctrlSyptoms lbSetCurSel -1;

    // ------------------------------------------------------------------ //

}, 0, []] call CBA_fnc_addPerFrameHandler;
