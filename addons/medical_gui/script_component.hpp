#define COMPONENT medical_gui
#define COMPONENT_BEAUTIFIED Neurotrauma - Medical GUI
#include "..\main\script_mod.hpp"

#include "..\medical_engine\Neuro_Medical_Marcos.hpp"
#include "..\medical_engine\Neuro_Medical_define.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "..\main\script_macros.hpp"

#include "..\medical_engine\Neuro_Medical_Marcos.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"
