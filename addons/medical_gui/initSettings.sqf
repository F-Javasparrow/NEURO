
[
    QGVAR(openAfterTreatment),
    "CHECKBOX",
    [LSTRING(OpenAfterTreatment_DisplayName), LSTRING(OpenAfterTreatment_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(maxDistance),
    "SLIDER",
    ["最大医疗距离", "最大医疗距离")],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    [0, 10, 3, 1],
    true
] call CBA_fnc_addSetting;

/*
* Default blood loss colouring follows a "white, yellow, red" colour scale with 10 steps, Bezier interpolation and Correct lightness gradient.
* See: https://gka.github.io/palettes
*/
private _bloodLossColors = [
    [1.00, 1.00, 1.00, 1],
    [1.00, 0.95, 0.64, 1],
    [1.00, 0.87, 0.46, 1],
    [1.00, 0.80, 0.33, 1],
    [1.00, 0.72, 0.24, 1],
    [1.00, 0.63, 0.15, 1],
    [1.00, 0.54, 0.08, 1],
    [1.00, 0.43, 0.02, 1],
    [1.00, 0.30, 0.00, 1],
    [1.00, 0.00, 0.00, 1]
];

/*
* Default damage colouring follows a "white, cyan, blue" colour scale with 10 steps, Bezier interpolation and Correct lightness gradient.
* See: https://gka.github.io/palettes
*/
private _damageColors = [
    [1.00, 1.00, 1.00, 1],
    [0.75, 0.95, 1.00, 1],
    [0.62, 0.86, 1.00, 1],
    [0.54, 0.77, 1.00, 1],
    [0.48, 0.67, 1.00, 1],
    [0.42, 0.57, 1.00, 1],
    [0.37, 0.47, 1.00, 1],
    [0.31, 0.36, 1.00, 1],
    [0.22, 0.23, 1.00, 1],
    [0.00, 0.00, 1.00, 1]
];

private _categoryColors = [ELSTRING(medical,Category), format ["| %1 |", LELSTRING(common,subcategory_colors)]];
{
    [
        format ["%1_%2", QGVAR(bloodLossColor), _forEachIndex],
        "COLOR",
        [format [localize LSTRING(BloodLossColorX_DisplayName), _forEachIndex], LSTRING(BloodLossColor_Description)],
        _categoryColors,
        _x,
        false // isGlobal
    ] call CBA_fnc_addSetting;
} forEach _bloodLossColors;

{
    [
        format ["%1_%2", QGVAR(damageColor), _forEachIndex],
        "COLOR",
        [format [localize LSTRING(DamageColorX_DisplayName), _forEachIndex], LSTRING(DamageColor_Description)],
        _categoryColors,
        _x,
        false // isGlobal
    ] call CBA_fnc_addSetting;
} forEach _damageColors;

[
    QGVAR(showBloodlossEntry),
    "CHECKBOX",
    [LSTRING(ShowBloodlossEntry_DisplayName), LSTRING(ShowBloodlossEntry_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    true,
    true // isGlobal
] call CBA_fnc_addSetting;
