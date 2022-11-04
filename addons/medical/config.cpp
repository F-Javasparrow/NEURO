#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
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
#include "Neuro_Medical_Treatments.hpp"

#include "..\medical_engine\Neuro_Medical_Symptoms.hpp"
#include "..\medical_engine\Neuro_Medical_Wounds.hpp"