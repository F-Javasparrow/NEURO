#define ADD_HITPOINTS\
    class HitLeftArm: HitHands {\
        material = -1;\
        name = "hand_l";\
        radius = 0.08;\
        visual = "injury_hands";\
        minimalHit = 0.01;\
    };\
    class HitRightArm: HitLeftArm {\
        name = "hand_r";\
    };\
    class HitLeftLeg: HitLegs {\
        material = -1;\
        name = "leg_l";\
        radius = 0.1;\
        visual = "injury_legs";\
        minimalHit = 0.01;\
    };\
    class HitRightLeg: HitLeftLeg {\
        name = "leg_r";\
    };\
    class neuro_hdbracket {\
        armor = 1;\
        material = -1;\
        name = "head";\
        passThrough = 0;\
        radius = 1;\
        explosionShielding = 1;\
        visual = "";\
        minimalHit = 0;\
        depends = "HitHead";\
    }

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        // General
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // BluFor
    class B_Soldier_base_F;
    class B_Soldier_04_f: B_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class B_Soldier_05_f: B_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // Indep
    class I_Soldier_base_F;
    class I_Soldier_03_F: I_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class I_Soldier_04_F: I_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // OpFor
    class SoldierEB;
    class O_Soldier_base_F: SoldierEB {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class O_Soldier_02_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class O_officer_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class O_Soldier_diver_base_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // Virtual Reality
    class B_Soldier_VR_F: B_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class B_Protagonist_VR_F: B_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class O_Soldier_VR_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class I_Soldier_VR_F: I_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class I_Protagonist_VR_F: I_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class O_Protagonist_VR_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class C_man_1;
    class C_Protagonist_VR_F: C_man_1 {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // Civilians
    class C_Soldier_VR_F: C_man_1 {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // APEX
    class O_V_Soldier_Viper_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
    class O_V_Soldier_base_F: O_Soldier_base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };

    // Enoch
    class I_E_Man_Base_F;
    class I_E_Uniform_01_coveralls_F: I_E_Man_Base_F {
        class HitPoints {
            class HitHands;
            class HitLegs;
            ADD_HITPOINTS;
        };
    };
};
