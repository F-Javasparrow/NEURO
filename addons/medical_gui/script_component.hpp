#define COMPONENT medical_gui
#define COMPONENT_BEAUTIFIED Neurotrauma - Medical GUI
#include "..\main\script_mod.hpp"

#include "..\medical_engine\Neuro_Medical_Marcos.hpp"
#include "..\medical_engine\Neuro_Medical_define.hpp"
#include "defineResincl.inc"
#include "defineDIKCodes.inc"
#include "defineCommonGrids.inc"
#include "defineCommonColors.inc"
#include "Neuro_Gui_Define.hpp"

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
