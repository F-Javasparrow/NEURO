#include "Neuro_Gui_Define.hpp"

class RscText;
class RscButton;
class RscPicture;
class RscListBox;
class RscActivePicture;
class RscButtonMenu;
class RscControlsGroupNoScrollbars;

class GVAR(BodyImage): RscControlsGroupNoScrollbars {
    idc = IDC_BODY_GROUP;
    x = POS_X(13.33);
    y = POS_Y(2.73);
    w = POS_W(12.33);
    h = POS_H(12.33);
    class controls {
        class Background: RscPicture {
            idc = -1;
            text = QPATHTOF(data\body_image\background.paa);
            x = 0;
            y = 0;
            w = POS_W(12.33);
            h = POS_H(12.33);
        };
        class Head: Background {
            idc = IDC_BODY_HEAD;
            text = QPATHTOF(data\body_image\head.paa);
        };

        class Torso: Background {
            idc = IDC_BODY_TORSO;
            text = QPATHTOF(data\body_image\torso.paa);
        };
        class ventral: Background {
            idc = IDC_BODY_VENTRAL;
            text = QPATHTOF(data\body_image\ventral.paa);
        };

        class ArmLeft: Background {
            idc = IDC_BODY_ARMLEFT;
            text = QPATHTOF(data\body_image\arm_left.paa);
        };
        class ArmRight: Background {
            idc = IDC_BODY_ARMRIGHT;
            text = QPATHTOF(data\body_image\arm_right.paa);
        };
        class LegLeft: Background {
            idc = IDC_BODY_LEGLEFT;
            text = QPATHTOF(data\body_image\leg_left.paa);
        };
        class LegRight: Background {
            idc = IDC_BODY_LEGRIGHT;
            text = QPATHTOF(data\body_image\leg_right.paa);
        };
    };
};

class Neuro_Medical_Menu {
    idd = IDD_MEDICAL_MENU;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(_this call FUNC(onMenuOpen));
    onUnload = QUOTE(_this call FUNC(onMenuClose));

    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT START (by COBRA-Javasparrow, v1.063, #Bilyfi)
    ////////////////////////////////////////////////////////

    // 主窗体
    class MenuBackPic: RscPicture
    {
        idc = 1200;
        text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.3)";
        x = 3 * GUI_GRID_W + GUI_GRID_X;
        y = 1 * GUI_GRID_H + GUI_GRID_Y;
        w = 46.5 * GUI_GRID_W;
        h = 20 * GUI_GRID_H;
    };
    class TitleBackPic: RscPicture
    {
        idc = 1201;
        text = "#(argb,8,8,3)color(0,0,0,1)";
        x = -10.5 * GUI_GRID_W + GUI_GRID_X;
        y = 0 * GUI_GRID_H + GUI_GRID_Y;
        w = 60 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class TitleText: RscText
    {
        idc = 1000;
        x = -10.5 * GUI_GRID_W + GUI_GRID_X;
        y = 0 * GUI_GRID_H + GUI_GRID_Y;
        w = 60 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };

    // 次窗体背景
    class BodySelectMenuBackPic: RscPicture
    {
        idc = 1202;
        text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.7)";
        x = -10.5 * GUI_GRID_W + GUI_GRID_X;
        y = 1 * GUI_GRID_H + GUI_GRID_Y;
        w = 13.5 * GUI_GRID_W;
        h = 20 * GUI_GRID_H;
    };
    class ActionBackPic: RscPicture
    {
        idc = 1203;
        text = "#(argb,8,8,3)color(1,1,1,0.6)";
        x = 22.5 * GUI_GRID_W + GUI_GRID_X;
        y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 26.5 * GUI_GRID_W;
        h = 17 * GUI_GRID_H;
    };
    class InfoBackPic: RscPicture
    {
        idc = 1204;
        text = "#(argb,8,8,3)color(1,1,1,0.6)";
        x = 3.5 * GUI_GRID_W + GUI_GRID_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y;
        w = 18.5 * GUI_GRID_W;
        h = 14.5 * GUI_GRID_H;
    };
    class HRBackPic: RscPicture
    {
        idc = 1205;
        text = "#(argb,8,8,3)color(1,1,1,1)";
        x = 3.5 * GUI_GRID_W + GUI_GRID_X;
        y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 18.5 * GUI_GRID_W;
        h = 4 * GUI_GRID_H;
    };

    // 部位选择
    class HeadSelect: RscButton {
        idc = 1600;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "head");
        tooltip = "Head"; //--- ToDo: Localize;
        x = -5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 2 * GUI_GRID_H + GUI_GRID_Y;
        w = 3.5 * GUI_GRID_W;
        h = 2.5 * GUI_GRID_H;
    };
    class TorsoSelect: RscButton {
        idc = 1601;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "torso");
        tooltip = "Torso"; //--- ToDo: Localize;
        x = -7 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 6.5 * GUI_GRID_W;
        h = 4.5 * GUI_GRID_H;
    };
    class VantralSelect: RscButton {
        idc = 1602;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "vantral");
        tooltip = "Vantral"; //--- ToDo: Localize;
        x = -6.5 * GUI_GRID_W + GUI_GRID_X;
        y = 10 * GUI_GRID_H + GUI_GRID_Y;
        w = 5.5 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class RightLegSelect: RscButton {
        idc = 1603;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "rightleg");
        tooltip = "RightLeg"; //--- ToDo: Localize;
        x = -6.5 * GUI_GRID_W + GUI_GRID_X;
        y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 2 * GUI_GRID_W;
        h = 5 * GUI_GRID_H;
    };
    class LeftLegSelect: RscButton {
        idc = 1604;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "leftleg");
        tooltip = "LeftLeg"; //--- ToDo: Localize;
        x = -3 * GUI_GRID_W + GUI_GRID_X;
        y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 2 * GUI_GRID_W;
        h = 5 * GUI_GRID_H;
    };
    class RightArmSelect: RscButton {
        idc = 1605;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "rightarm");
        tooltip = "RightArm"; //--- ToDo: Localize;
        x = -9 * GUI_GRID_W + GUI_GRID_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 1.5 * GUI_GRID_W;
        h = 5.5 * GUI_GRID_H;
    };
    class LeftArmSelect: RscButton {
        idc = 1606;
        onButtonClick = QUOTE(GVAR(selectedMainPart) = "leftarm");
        tooltip = "LeftArm"; //--- ToDo: Localize;
        x = 0 * GUI_GRID_W + GUI_GRID_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 1.5 * GUI_GRID_W;
        h = 5.5 * GUI_GRID_H;
    };
    
    // 类选择
    class ActionClass: RscToolbox {
        idc = 1610;
        checked_strings[] = {"Checks","Wounds","Circulation","pharma","Surgery","Other"};
        rows = 1;
	    columns = 6;
        x = 22.5 * GUI_GRID_W + GUI_GRID_X;
        y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 26.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    // 子按钮
    class Action1: RscButtonMenu {
        idc = IDC_ACTION_1;
            style = ST_LEFT;
        x = 23 * GUI_GRID_W + GUI_GRID_X;
        y = 4 * GUI_GRID_H + GUI_GRID_Y;
        w = 12.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
        size = 0.9 * GUI_GRID_H;
        class Attributes {
            align = "center";
            color = "#E5E5E5";
            font = "RobotoCondensed";
            shadow = "false";
        };
    };
    class Action2: Action1 {
        idc = IDC_ACTION_2;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action3: Action1 {
        idc = IDC_ACTION_3;
        y = 7 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action4: Action1 {
        idc = IDC_ACTION_4;
        y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action5: Action1 {
        idc = IDC_ACTION_5;
        y = 10 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action6: Action1 {
        idc = IDC_ACTION_6;
        y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action7: Action1 {
        idc = IDC_ACTION_7;
        y = 13 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action8: Action1 {
        idc = IDC_ACTION_8;
        y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action9: Action1 {
        idc = IDC_ACTION_9;
        y = 16 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action10: Action1 {
        idc = IDC_ACTION_10;
        y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
    };
    class Action11: Action1 {
        idc = IDC_ACTION_11;
        y = 19 * GUI_GRID_H + GUI_GRID_Y;
    };

    // 数据输出
    class TreatmentHeader: RscText {
        idc = -1;
        style = ST_CENTER;
        text = "test";
        x = 36 * GUI_GRID_W + GUI_GRID_X;
        y = 4 * GUI_GRID_H + GUI_GRID_Y;
        w = 12.5 * GUI_GRID_W;
        h = 16 * GUI_GRID_H;
        sizeEx = 20 * GUI_GRID_H;
        colorText[] = {1, 1, 1, 0.9};
    };
    
    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT END
    ////////////////////////////////////////////////////////

};
