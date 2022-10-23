#include "script_component.hpp"
ADDON = false;

#include "XEH_PREP.hpp"

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

call FUNC(parseConfigForSymptoms);

addMissionEventHandler ["Loaded",{
    call FUNC(parseConfigForSymptoms);
}];

[QEGVAR(medical,woundReceived), LINKFUNC(woundReceived)] call CBA_fnc_addEventHandler;
[QEGVAR(medical,addSymptom), LINKFUNC(addSymptom)] call CBA_fnc_addEventHandler;

ADDON = true;