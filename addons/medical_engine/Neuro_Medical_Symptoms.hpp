class Neuro_Medical_Symptoms {
	class symptomHandler {
		ADDON = QFUNC(symptomHandlerBase);
	};

	class SysmptomBase {
		selections = ALL_BODY_PARTS;
		visableLevel = 1;
		visableValue = [0,100];
		causeSymptom = [];
		reduceSymptom = [];
		class symptomHandlers: symptomHandler {};
		class details {
			type = "Sysmptom"
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
	};
// 症状
	// 血液
	class Bleeding: SysmptomBase {
		visableLevel = 0;
		visableValue = [10,100];
		class details {
			type = "Sysmptom"
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [];
		reduceSymptom = [];
	};

	// 头部

	// 肺部

	// 心脏
	class CardiacArrest: SysmptomBase {
		visableLevel = 1;
		visableValue = [0,100];
		class details {
			type = "Sysmptom"
			changeHR = [-100,-150,-500];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [];
		reduceSymptom = [];
	};

	// 躯干

	// 四肢

	// 骨骼

	// 其他

// 伤口
	class WoundBase: SysmptomBase {
		visableLevel = 0;
		class details {
			type = "Wound"
			mutilate = 1;
			bloodLosing = [0,0,0];
		};
	};
	class Wound_Gunshot: WoundBase {
		class details {
			mutilate = 1;
		};
		causeSymptom = [[0.75, "Bleeding", 0.5]];
		reduceSymptom = [];
	};
	class Wound_Internal: WoundBase {
		visableValue = [30,100];
		class details {
			mutilate = 0.2;
		};
		causeSymptom = [];
		reduceSymptom = [];
	};
	class Wound_Lacerations: WoundBase {
		class details {
			mutilate = 0.2;
		};
		causeSymptom = [[0.75, "Bleeding", 0.5]];
		reduceSymptom = [];
	};
};