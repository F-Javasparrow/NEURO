#define COMPONENT medical_engine
#define COMPONENT_BEAUTIFIED Neurotrauma - Medical_engine
#include "\x\neuro\addons\main\script_mod.hpp"

#include "Neuro_Medical_Marcos.hpp"
#include "Neuro_Medical_define.hpp"
#include "Neuro_Medical_Symptoms.hpp"
#include "Neuro_Medical_Wounds.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "\x\neuro\addons\main\script_macros.hpp"
