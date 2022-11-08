#include "script_component.hpp"
params["_item", "_needNum"];
private _unit = player;
private _allItems = vestItems _unit + uniformItems _unit + backpackItems _unit;
private _hasNum = ({_x isEqualTo _item} count _allItems);

if(_needNum <= _hasNum) exitWith {true};

false;