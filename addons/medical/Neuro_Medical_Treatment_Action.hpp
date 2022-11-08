class Neuro_Medical_Treatment_Actions {
	class ActionsBase {
		category = "Other";
		condition = "true";
		statement = "";
		needTime = 5;
		needItem[] = {};
		consumeItem[] = {};
	};

	// 检查
	class CheckInjuries: ActionsBase {
		displayName = "检查伤情";
		category = "Checks";
		condition = "true";
		statement = QSFUNC(checkInjuries);
		needTime = 8;
		needItem[] = {};
		consumeItem[] = {};
	};
	class ConnectionMonitor: ActionsBase {
		displayName = "连接监控";
		category = "Checks";
		condition = "true";
		statement = QSFUNC(connectionMonitor);
		needItem[] = {};
		consumeItem[] = {};
	};

	// 伤口
	class RinseWound: ActionsBase {
		displayName = "冲洗伤口";
		category = "Wounds";
		condition = "true";
		statement = QSFUNC(rinseWound);
		needItem[] = {};
		consumeItem[] = {};
	};
	class DisinfectWound: ActionsBase {
		displayName = "消毒伤口";
		category = "Wounds";
		condition = "true";
		statement = QSFUNC(disinfectWound);
		needItem[] = {};
		consumeItem[] = {};
	};
	class DebridementWound: ActionsBase {
		displayName = "清创伤口";
		category = "Wounds";
		condition = "true";
		statement = QSFUNC(debridementWound);
		needItem[] = {};
		consumeItem[] = {};
	};
	class SutureWound: ActionsBase {
		displayName = "缝合伤口";
		category = "Wounds";
		condition = "true";
		statement = QSFUNC(sutureWound);
		needItem[] = {};
		consumeItem[] = {};
	};

	// 循环系统
	class CPR: ActionsBase {
		displayName = "进行CPR";
		category = "Circulation";
		condition = "true";
		statement = QSFUNC(cpr);
		needTime = 30;
		needItem[] = {};
		consumeItem[] = {};
	};
	class AED: ActionsBase {
		displayName = "进行AED除颤";
		category = "Circulation";
		condition = "true";
		statement = QSFUNC(aed);
		needTime = 8;
		needItem[] = {};
		consumeItem[] = {};
	};

	// 药物
	class Dopamine: ActionsBase {
		displayName = "推注多巴胺";
		category = "Pharma";
		condition = "['Neuro_Dopamine',1] call neuro_medical_fnc_hasItem";
		statement = QSFUNC(dopamine);
		needTime = 5;
		needItem[] = {"Neuro_Dopamine"};
		consumeItem[] = {"Neuro_Dopamine"};
	};
	class Epinephrine: ActionsBase {
		displayName = "推注肾上腺素";
		category = "Pharma";
		condition = "['Neuro_Epinephrine',1] call neuro_medical_fnc_hasItem";
		statement = QSFUNC(epinephrine);
		needTime = 5;
		needItem[] = {"Neuro_Epinephrine"};
		consumeItem[] = {"Neuro_Epinephrine"};
	};
	class Norepinephrine: ActionsBase {
		displayName = "推注去甲肾上腺素";
		category = "Pharma";
		condition = "['Neuro_Norepinephrine',1] call neuro_medical_fnc_hasItem";
		statement = QSFUNC(norepinephrine);
		needTime = 5;
		needItem[] = {"Neuro_Norepinephrine"};
		consumeItem[] = {"Neuro_Norepinephrine"};
	};
	class Nikethamide: ActionsBase {
		displayName = "推注尼可刹米";
		category = "Pharma";
		condition = "['Neuro_Nikethamide',1] call neuro_medical_fnc_hasItem";
		statement = QSFUNC(nikethamide);
		needTime = 5;
		needItem[] = {"Neuro_Nikethamide"};
		consumeItem[] = {"Neuro_Nikethamide"};
	};
	class Lidocaine: ActionsBase {
		displayName = "推注利多卡因";
		category = "Pharma";
		condition = "['Neuro_Lidocaine',1] call neuro_medical_fnc_hasItem";
		statement = QSFUNC(lidocaine);
		needTime = 5;
		needItem[] = {"Neuro_Lidocaine"};
		consumeItem[] = {"Neuro_Lidocaine"};
	};
	class Morphine: ActionsBase {
		displayName = "推注吗啡";
		category = "Pharma";
		condition = "['Neuro_Morphine',1] call neuro_medical_fnc_hasItem";
		statement = QSFUNC(morphine);
		needTime = 5;
		needItem[] = {"Neuro_Morphine"};
		consumeItem[] = {"Neuro_Morphine"};
	};

	// 手术

	// 其他
};