#include "script_component.hpp"
params["_item", "_usedNum"];
private _unit = player;
private _allItems = vestItems _unit + uniformItems _unit + backpackItems _unit;

if([_item,_usedNum] call FUNC(hasItem)) exitWith {
	for "_i" from 1 to _usedNum do {
		_unit removeItem _item;
	};

	true;
};

false;