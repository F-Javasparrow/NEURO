#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#ifdef DISABLE_COMPILE_CACHE
  #undef PREP
  #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
  #undef PREP
  #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

// item types
#define TYPE_DEFAULT         0
#define TYPE_MUZZLE          101
#define TYPE_OPTICS          201
#define TYPE_FLASHLIGHT      301
#define TYPE_BIPOD           302
#define TYPE_FIRST_AID_KIT   401
#define TYPE_FINS            501
#define TYPE_BREATHING_BOMB  601
#define TYPE_NVG             602
#define TYPE_GOGGLE          603
#define TYPE_SCUBA           604
#define TYPE_HEADGEAR        605
#define TYPE_FACTOR          607
#define TYPE_RADIO           611
#define TYPE_HMD             616
#define TYPE_BINOCULAR       617
#define TYPE_MEDIKIT         619
#define TYPE_TOOLKIT         620
#define TYPE_UAV_TERMINAL    621
#define TYPE_VEST            701
#define TYPE_UNIFORM         801
#define TYPE_BACKPACK        901

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}