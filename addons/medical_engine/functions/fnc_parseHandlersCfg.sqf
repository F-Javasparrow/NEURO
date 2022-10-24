#include "script_component.hpp"
params ["_config"];

private _entries = [];
{
    private _entryResult = call compile getText _x;
    if !(isNil "_entryResult") then {
        _entries pushBack _entryResult;
    }
} forEach configProperties [_config, "isText _x", false];

private _parent = inheritsFrom _config;
if (isNull _parent) exitWith {_entries};

([_parent] call FUNC(parseHandlersCfg)) + _entries;
