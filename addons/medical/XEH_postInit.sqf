#include "script_component.hpp"

call FUNC(parseConfigForTreatments);
addMissionEventHandler ["Loaded",{
    call FUNC(parseConfigForTreatments);
}];

[QEGVAR(medical,addMedication), LINKFUNC(addMedication)] call CBA_fnc_addEventHandler;