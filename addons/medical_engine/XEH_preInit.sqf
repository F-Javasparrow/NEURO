#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(hitPartCache) = createHashMapFromArray [
	["hithead", ["head", "crown"]],
	["hitface", ["head", "face"]],
	["hitneck", ["head", "neck"]],
	["hitchest", ["torso", "chest"]],
	["hitdiaphragm", ["torso", "diaphragm"]],
	["hitpelvis", ["ventral", "pelvis"]],
	["hitabdomen", ["ventral", "abdomen"]],
	["hitleftarm", ["leftarm", "leftarm"]],
	["hitrightarm", ["rightarm", "rightarm"]],
	["hitleftleg", ["leftleg", "leftleg"]],
	["hitrightleg", ["rightleg", "rightleg"]]
];

[QEGVAR(medical,woundReceived), {_this call FUNC(woundReceived)}] call CBA_fnc_addEventHandler;
[QEGVAR(medical,addSymptom), {_this call FUNC(addSymptom)}] call CBA_fnc_addEventHandler;

ADDON = true;