#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {
            "Neuro_Dopamine",
            "Neuro_Epinephrine",
            "Neuro_Norepinephrine",
            "Neuro_Nikethamide",
            "Neuro_Lidocaine",
            "Neuro_Morphine"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main"
        };
        author = "Javasparrow";
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "Neuro_Medical_Treatment_Action.hpp"
#include "Neuro_Medical_Treatments.hpp"

#include "..\medical_engine\Neuro_Medical_Symptoms.hpp"
#include "..\medical_engine\Neuro_Medical_Wounds.hpp"