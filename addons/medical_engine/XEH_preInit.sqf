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
EGVAR(meidical,woundOfDamage) = createHashMap;

[QEGVAR(medical,woundReceived), LINKFUNC(woundReceived)] call CBA_fnc_addEventHandler;
[QEGVAR(medical,addSymptom), LINKFUNC(addSymptom)] call CBA_fnc_addEventHandler;

[QEGVAR(medical,handleSymptom), LINKFUNC(handleSymptom)] call CBA_fnc_addEventHandler;
[QEGVAR(medical,handleMedicalStatus), LINKFUNC(handleMedicalStatus)] call CBA_fnc_addEventHandler;

ADDON = true;