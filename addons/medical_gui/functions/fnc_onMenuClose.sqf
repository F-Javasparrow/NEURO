#include "script_component.hpp"
/*
 * Author: joko // Jonas
 * Handles closing the Medical Menu. Called from onUnload event.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_medical_gui_fnc_onMenuClose
 *
 * Public: No
 */

GVAR(pendingReopen) = false;
GVAR(menuPFH) call CBA_fnc_removePerFrameHandler;
GVAR(menuPFH) = -1;
