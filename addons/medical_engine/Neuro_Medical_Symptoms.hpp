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
			displayName = "默认症状";
			displayDesc = "默认症状描述";
			type = "Sysmptom";
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
			displayName = "失血";
			displayDesc = "患者正在涌出血液";
			type = "Sysmptom";
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [];
		reduceSymptom = [];
	};

	// 头部
	class Coma: SysmptomBase {
		selections = ["head"];
		visableLevel = 0;
		visableValue = [0,100];
		class details {
			displayName = "昏迷";
			displayDesc = "处于深度昏迷";
			type = "Sysmptom";
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [["CardiacArrest", 0.40, "set", 1]];
		reduceSymptom = [];
	};

	// 肺部
	class Pneumothorax: SysmptomBase {
		visableLevel = 1.5;
		visableValue = [0.75,1];
		class details {
			displayName = "气胸 ";
			displayDesc = "气胸会阻止低血氧的降低 虽然气胸本身并不致命.但如果与导致低氧血症的病症搭配 气胸很容易致死 气胸的负面作用可以通过使用气胸针暂时抵消";
			type = "Sysmptom";
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [];
		reduceSymptom = [];
	};
		

	// 心脏
	class CardiacArrest: SysmptomBase {
		visableLevel = 1;
		visableValue = [0,100];
		class details {
			displayName = "心搏停止";
			displayDesc = "心搏停止";
			type = "Sysmptom";
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [];
		reduceSymptom = [];
	};

	// 躯干
	class InternalBleeding; SysmptomBase {
	        visableLevel = 1;
		visableValue = [0.2,1]；
	        class details {
			displayName = "内出血";
			displayDesc = "内出血会迅速让病人失血，必须迅速处理";
			type = "Sysmptom";
			changeHR = [0,0,0];
			changeRR = [0,0,0];
			changePain = [0,0,0];
			changeSPo2 = [0,0,0];
		};
		causeSymptom = [];
		reduceSymptom = [];
	};
			
	// 四肢

	// 骨骼
	class Fracture: SysmptomBase {
		visableLevel = 0.5;
		visableValue = [0,1];
		class details {
			displayName = "骨折";
			displayDesc = "感觉有根骨头断了";
			type = "Sysmptom";
		};
		causeSymptom = [["Bleeding", "_SAME_", 0.85, "add", 0.25]];
	};

	// 其他

// 伤口
	class WoundBase: SysmptomBase {
		visableLevel = 0;
		class details {
			displayName = "默认伤口";
			displayDesc = "默认伤口描述";
			type = "Wound";
			mutilate = 1;
			bloodLosing = [0,0,0];
		};
	};
	class Wound_Gunshot: WoundBase {
		class details {
			displayName = "枪伤";
			displayDesc = "贯穿类伤口";
			mutilate = 1;
		};
		causeSymptom = [["Bleeding", 0.15, "add", 0.15]];
		reduceSymptom = [];
	};
	class Wound_Internal: WoundBase {
		visableValue = [30,100];
		class details {
			displayName = "深层组织损伤";
			displayDesc = "患者皮下组织受到严重伤害";
			mutilate = 0.2;
		};
		causeSymptom = [];
		reduceSymptom = [];
	};
	class Wound_Lacerations: WoundBase {
		class details {
			displayName = "割伤";
			displayDesc = "由利器造成的伤口";
			mutilate = 0.2;
		};
		causeSymptom = [["Bleeding", 0.15, "add", 0.15]];
		reduceSymptom = [];
	};
};
