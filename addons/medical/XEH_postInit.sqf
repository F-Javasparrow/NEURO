#include "script_component.hpp"

EGVAR(meidical,medicationTypeCache) = createHashMap;
EGVAR(meidical,medicationDetails) = createHashMap;
call FUNC(parseConfigForTreatments);
addMissionEventHandler ["Loaded",{
    call FUNC(parseConfigForTreatments);
}];
