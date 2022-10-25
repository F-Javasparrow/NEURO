#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(Inedx2MainPart) = createHashMapFromArray [
	[0,"head"],
	[1,"torso"],
	[2,"ventral"],
	[3,"leftarm"],
	[4,"rightarm"],
	[5,"leftleg"],
	[6,"rightleg"]
];

#include "initSettings.sqf"

ADDON = true;