#include "script_component.hpp"
params ["_unit", "_selection", "_damage", "_shooter", "_ammo", "_hitPointIndex", "_instigator", "_hitpoint"];

if !(local _unit) exitWith {nil};

private _oldDamage = 0;
if (_hitPoint isEqualTo "") then {
    _hitPoint = "#structural";
    _oldDamage = damage _unit;
} else {
    _oldDamage = _unit getHitIndex _hitPointIndex;
};

if !(isDamageAllowed _unit) exitWith {_oldDamage};

if (
    _hitPoint isEqualTo "#structural" &&
    {getOxygenRemaining _unit <= 0.5} &&
    {_damage isEqualTo (_oldDamage + 0.005)}
) exitWith {0};

// 确定部位
GVAR(hitPartCache) get _hitpoint params ["_mainHitPart", "_subHitPart"];

if (_hitPoint isEqualTo "neuro_hdbracket") exitWith {
    // --- head
    private _subDamageFace = _unit getVariable [QGVAR(@HitFace), [0, ["head", "face"]]];
    private _subDamageNeck = _unit getVariable [QGVAR(@HitNeck), [0, ["head", "neck"]]];
    private _subDamageHead = _unit getVariable [QGVAR(@HitHead), [0, ["head", "crown"]]];

    private _mainDamageHead = [_subDamageFace, _subDamageNeck, _subDamageHead];
    _mainDamageHead sort false;
    _mainDamageHead = _mainDamageHead select 0;

    // --- torso
    private _subDamageChest = _unit getVariable [QGVAR(@HitChest), [0, ["torso", "chest"]]];
    private _subDamageDiaphragm = _unit getVariable [QGVAR(@HitDiaphragm), [0, ["torso", "diaphragm"]]];

    private _mainDamageTorso = [_subDamageChest, _subDamageDiaphragm];
    _mainDamageTorso sort false;
    _mainDamageTorso = _mainDamageTorso select 0;

    // --- ventral
    private _subDamagePelvis = _unit getVariable [QGVAR(@HitPelvis), [0, ["ventral", "pelvis"]]];
    private _subDamageAbdomen = _unit getVariable [QGVAR(@HitAbdomen), [0, ["ventral", "abdomen"]]];

    private _mainDamageVentral = [_subDamageChest, _subDamageDiaphragm];
    _mainDamageVentral sort false;
    _mainDamageVentral = _mainDamageVentral select 0;

    // --- Arms and Legs
    private _damageLeftArm  = _unit getVariable [QGVAR(@HitLeftArm),  [0,[ "leftarm", "leftarm"]]];
    private _damageRightArm = _unit getVariable [QGVAR(@HitRightArm), [0, ["rightarm", "rightarm"]]];
    private _damageLeftLeg  = _unit getVariable [QGVAR(@HitLeftLeg),  [0, ["leftleg", "leftleg"]]];
    private _damageRightLeg = _unit getVariable [QGVAR(@HitRightLeg), [0, ["rightleg", "rightleg"]]];

    private _allDamages = [
        _mainDamageHead,
        _mainDamageTorso, _mainDamageVentral,
        _damageLeftArm, _damageRightArm,
        _damageLeftLeg, _damageRightLeg
    ];

    _allDamages sort false;
    
    if ((_allDamages select 0 select 0) > 0.0001) then {
        [QEGVAR(medical,woundReceived), [_unit, _allDamages, _ammo]] call CBA_fnc_localEvent;
    };

    {
        _unit setVariable [_x, nil];
    } forEach [
        QGVAR(@HitFace),QGVAR(@HitNeck),QGVAR(@HitHead),
        QGVAR(@HitPelvis),QGVAR(@HitAbdomen),QGVAR(@HitDiaphragm),QGVAR(@HitChest),QGVAR(@HitBody),
        QGVAR(@HitLeftArm),QGVAR(@HitRightArm),QGVAR(@HitLeftLeg),QGVAR(@HitRightLeg),
        QGVAR(@#structural)
    ];

    0;
};

_unit setVariable [format [QGVAR(@%1), _hitPoint], [_damage, [_mainHitPart/* , _subHitPart */]]];

0
