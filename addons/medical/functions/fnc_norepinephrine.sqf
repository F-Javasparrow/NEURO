#include "script_component.hpp"
params ["_unit", "_mainPart"];

SYNCVAR(medical_gui,target);
SYNCVAR(medical_gui,selectedMainPart);

["Neuro_Norepinephrine", 1] call FUNC(useItem);
[QGVAR(addMedication), [GVAR(target), "Norepinephrine", 1, GVAR(selectedMainPart)], GVAR(target)] call CBA_fnc_targetEvent;