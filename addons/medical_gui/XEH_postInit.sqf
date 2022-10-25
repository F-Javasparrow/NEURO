#include "script_component.hpp"

if (!hasInterface) exitWith {};

[] call FUNC(collectActions);

GVAR(selectedMainPart) = 0;
GVAR(menuPFH) = -1;

["Neuro medical", QGVAR(openMedicalMenuKey), "打开医疗菜单", {
    private _target = cursorTarget;
    if !(_target isKindOf "CAManBase" && {[(call CBA_fnc_currentUnit), _target] call FUNC(canOpenMenu)}) then {
        _target = cursorObject;
        if !(_target isKindOf "CAManBase" && {[(call CBA_fnc_currentUnit), _target] call FUNC(canOpenMenu)}) then {
            private _start = AGLToASL positionCameraToWorld [0, 0, 0];
            private _end = AGLToASL positionCameraToWorld [0, 0, 3/* GVAR(maxDistance) */];
            private _intersections = lineIntersectsSurfaces [_start, _end, (call CBA_fnc_currentUnit), objNull, true, -1, "FIRE"];
            {
                _x params ["", "", "_intersectObject"];
                if (!(_intersectObject isKindOf "CAManBase") && {_intersectObject != vehicle (call CBA_fnc_currentUnit)}) exitWith {};
                if (_intersectObject != (call CBA_fnc_currentUnit) && {_intersectObject isKindOf "CAManBase" && {[(call CBA_fnc_currentUnit), _intersectObject] call FUNC(canOpenMenu)}}) exitWith {
                    _target =_intersectObject
                };
            } forEach _intersections;
            if (!(_target isKindOf "CAManBase") || {!([(call CBA_fnc_currentUnit), _target] call FUNC(canOpenMenu))}) then {
                _target = (call CBA_fnc_currentUnit);
            };
        };
    };

    if !([(call CBA_fnc_currentUnit), _target, ["isNotInside", "isNotSwimming"]] call EFUNC(common,canInteractWith)) exitWith {false};
    if !([(call CBA_fnc_currentUnit), _target] call FUNC(canOpenMenu)) exitWith {false};

    // Statement
    [_target] call FUNC(openMenu);
    false
}, {
    if (CBA_missionTime - GVAR(lastOpenedOn) > 0.5) exitWith {
        [objNull] call FUNC(openMenu);
    };
    false
}, [DIK_H, [false, false, false]], false, 0] call CBA_fnc_addKeybind;
