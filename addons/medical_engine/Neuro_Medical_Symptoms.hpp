class Neuro_Medical_Symptoms {
	class symptomHandler {
		ADDON = QFUNC(symptomHandlerBase);
	};

	class SymptomBase {
		selections = ALL_BODY_PARTS;
		visableLevel = 1;
		visableValue[] = {0,1};
		maxSeverity = 1;
		class details {
			displayName = "默认症状";
			displayDesc = "默认症状描述";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
		class symptomHandlers: symptomHandler {};
	};
// 症状
	// 血液
	class Bleeding: SymptomBase {
		visableLevel = 0;
		visableValue[] = {0.1,1};
		maxSeverity = 2;
		class details {
			displayName = "失血";
			displayDesc = "患者正在涌出血液";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};

	// 头部
	class Coma: SymptomBase {
		selections = "head";
		visableLevel = 0;
		visableValue[] = {0,1};
		class details {
			displayName = "昏迷";
			displayDesc = "处于深度昏迷";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {
			class CardiacArrest {
				addPart = "torso";
				type = "set";
				severityThreshold = 0.4;
				perAdd = 1;
				repeat = 1.5;
			};
		};
		class reduceSymptom {};
	};

	// 肺部
	class Pneumothorax: SysmptomBase {
		selections = "torso";
		visableLevel = 1.5;
		visableValue[] = {0.75,1};
		class details {
			displayName = "气胸 ";
			displayDesc = "气胸会阻止低血氧的降低 虽然气胸本身并不致命.但如果与导致低氧血症的病症搭配 气胸很容易致死 气胸的负面作用可以通过使用气胸针暂时抵消";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};	

	// 心脏
	class CardiacArrest: SymptomBase {
		selections = "torso";
		visableLevel = 0.8;
		visableValue[] = {0,1};
		class details {
			displayName = "心搏停止";
			displayDesc = "心搏停止";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};

	// 躯干
	class InternalBleeding: SysmptomBase {
		selections = "torso";
	    visableLevel = 1;
		visableValue[] = {0.2,1};
		maxSeverity = 2;
	    class details {
			displayName = "内出血";
			displayDesc = "内出血会迅速让病人失血，必须迅速处理";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
			
	// 四肢

	// 骨骼
	class Fracture: SysmptomBase {
		visableLevel = 0.5;
		visableValue[] = {0,1};
		class details {
			displayName = "骨折";
			displayDesc = "感觉有根骨头断了";
			type = "Sysmptom";
		};
		class causeSymptom {
			class Bleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.15;
				perAdd = 0.015;
				repeat = -1;
			};
		};
	};

	// 其他
	class Unconsciousness: SymptomBase {
		selections = "head";
		visableLevel = 0;
		visableValue[] = {0,1};
		class details {
			displayName = "无意识";
			displayDesc = "患者呼之不应";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};

// 伤口
	class WoundBase: SymptomBase {
		visableLevel = 0;
		class details {
			displayName = "默认伤口";
			displayDesc = "默认伤口描述";
			type = "Wound";
			mutilate = 1;
		};
	};
	class WoundGunshot: WoundBase {
		class details {
			displayName = "枪伤";
			displayDesc = "贯穿类伤口";
			mutilate = 1;
		};
		class causeSymptom {
			class Bleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.15;
				perAdd = 0.015;
				repeat = -1;
			};
		};
		class reduceSymptom {};
	};
	class WoundInternal: WoundBase {
		visableValue[] = {30,100};
		class details {
			displayName = "深层组织损伤";
			displayDesc = "患者皮下组织受到严重伤害";
			mutilate = 0.2;
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
	class WoundLacerations: WoundBase {
		class details {
			displayName = "割伤";
			displayDesc = "由利器造成的伤口";
			mutilate = 0.2;
		};
		class causeSymptom {
			class Bleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.15;
				perAdd = 0.015;
				repeat = -1;
			};
		};
		class reduceSymptom {};
	};
};
