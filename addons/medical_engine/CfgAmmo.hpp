#define DAMAGE_PROJECTILE    {"WoundGunshot", 2, "WoundLacerations", 0.2}
#define DAMAGE_EXPLOSIVE     {"WoundInternal", 1.8}
#define DAMAGE_GRENADE       {"WoundLacerations", 1, "WoundInternal", 0.8}
#define DAMAGE_SHELL         {"WoundLacerations", 1.8, "WoundInternal", 1.5}

class CfgAmmo {
    class BulletCore;
    class BulletBase: BulletCore {
        Neuro_woundOfDamage[] = DAMAGE_PROJECTILE;
    };
    class ShotgunCore;
    class ShotgunBase: ShotgunCore {
        Neuro_woundOfDamage[] = DAMAGE_PROJECTILE;
    };

    class Default;
    class FuelExplosion: Default {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class Grenade: Default {
        Neuro_woundOfDamage[] = DAMAGE_GRENADE;
    };
    class GrenadeCore;
    class GrenadeBase: GrenadeCore {
        Neuro_woundOfDamage[] = DAMAGE_GRENADE;
    };

    class MineCore;
    class MineBase: MineCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class PipeBombCore;
    class PipeBombBase: PipeBombCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class DirectionalBombCore;
    class DirectionalBombBase: DirectionalBombCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class BoundingMineCore;
    class BoundingMineBase: BoundingMineCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };

    class RocketCore;
    class RocketBase: RocketCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class MissileCore;
    class MissileBase: MissileCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };

    class SubmunitionCore;
    class SubmunitionBase: SubmunitionCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class SubmunitionBullet: SubmunitionBase {
        Neuro_woundOfDamage[] = DAMAGE_PROJECTILE;
    };

    class ShellCore;
    class ShellBase: ShellCore {
        Neuro_woundOfDamage[] = DAMAGE_SHELL;
    };

    class BombCore;
    class Bo_Mk82: BombCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class LaserBombCore;
    class ammo_Bomb_LaserGuidedBase: LaserBombCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class BombDemine_01_Ammo_F: BombCore {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };

    class B_19mm_HE: BulletBase {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class B_20mm: BulletBase {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class B_25mm: BulletBase {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
    class B_35mm_AA: BulletBase {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };

    class Gatling_30mm_HE_Plane_CAS_01_F: BulletBase {
        Neuro_woundOfDamage[] = DAMAGE_EXPLOSIVE;
    };
};
