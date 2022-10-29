class Neuro_Medical_Symptoms {
	class symptomHandler {
		ADDON = QFUNC(symptomHandlerBase);
	};

	class SymptomBase {
		selections[] = {"head", "torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
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
			displayName = "流血";
			displayDesc = "患者正在涌出血液";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
			bloodLosing[] = {5,25};
		};
		
	};

	// 头部
	class Coma: SymptomBase {
		selections[] = {"head"};
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
	class Unconsciousness: SymptomBase {
		selections[] = {"head"};
		visableLevel = 0;
		visableValue[] = {0,1};
		class details {
			displayName = "无意识";
			displayDesc = "无意识通常意味着发生了非常严重的问题，医生需要尽快对你进行治疗";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {
			class Headache {
				addPart = "head";
				type = "add";
				severityThreshold = 0;
				perAdd = 0.02;
				repeat = -1;
			};
		};
	};
	class Concussion: SymptomBase {
		selections[] = {"head"};
		visableLevel = 0.75;
		visableValue[] = {0,1};
		class details {
			displayName = "脑震荡";
			displayDesc = "虽然是个麻烦,但它并不致命";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
	};
	class Headache: SymptomBase {
		selections[] = {"head"};
		visableLevel = 0.75;
		visableValue[] = {0,1};
		class details {
			displayName = "头痛";
			displayDesc = "虽然是个麻烦,但它并不致命";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
	};

	// 肺部
	class Pneumothorax: SysmptomBase {
		selections[] = {"torso"};
		visableLevel = 1.5;
		visableValue[] = {0.75,1};
		class details {
			displayName = "气胸";
			displayDesc = "气胸会阻止低血氧的降低 虽然气胸本身并不致命.";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0.05};
		};
		class causeSymptom {
			class ShortnessBreath {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.4;
				perAdd = 0.02;
				repeat = -1;
			}
		};
	};
	class RespiratoryArrest: SysmptomBase {
		selections[] = {"torso"};
		visableLevel = 1.5;
		visableValue[] = {0,1};
		class details {	
			displayName = "呼吸停止";
			displayDesc = "呼吸停止将迅速导致缺氧,使病人窒息,必须迅速处理";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,-0.15};
		};
		
	};
	class ShortnessBreath: SysmptomBase {
		selections[] = {"torso"};
		visableLevel = 1.5;
		visableValue[] = {0,1};
		class details {	
			displayName = "呼吸急促";
			displayDesc = "呼吸急促是一种症状，这意味着它是非致命的";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,20};
		};
	};

	// 心脏
	class IncreasedHeartrate: SymptomBase {
		selections[] = {"torso"};
		visableLevel = 3;
		visableValue[] = {0,1};
		class details {
			displayName = "心率加快";
			displayDesc = "这意味着你正在经历心颤";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {
			class IrregularHeartbeat {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 1;
				perAdd = 0.05;
				repeat = -1;
			};
		};
		class reduceSymptom {};
	};
	class IrregularHeartbeat: SymptomBase {
		selections[] = {"torso"};
		visableLevel = 3;
		visableValue[] = {0,1};
		class details {
			displayName = "心率不齐";
			displayDesc = "心脏不按正常速度跳动,可导致心搏骤停";
			type = "Symptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {
			class CardiacArrest {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.20;
				perAdd = 0.05;
				repeat = 0.2;
			};
		};
		class reduceSymptom {};
	};
	class CardiacArrest: SymptomBase {
		selections[] = {"torso"};
		visableLevel = 0.75;
		visableValue[] = {0,1};
		class details {
			displayName = "心搏停止";
			displayDesc = "心搏停止";
			type = "Symptom";
			changeHR[] = {-1,-10};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		
	};

	// 躯干
	class InternalBleeding: SysmptomBase {
		selections[] = {"torso", "ventral"};
	    visableLevel = 1;
		visableValue[] = {0.2,1};
		maxSeverity = 2;
	    class details {
			displayName = "内出血";
			displayDesc = "内出血会迅速让病人失血,必须迅速处理";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		
	};
	class AorticRupture: SysmptomBase {
		selections[] = {"torso", "ventral"};
	    visableLevel = 1;
		visableValue[] = {0.2,1};
	    class details {
			displayName = "主动脉破裂";
			displayDesc = "主动脉破裂是一个人可能经历的最严重的伤害之一";
			type = "Sysmptom";
			changeHR[] = {0,0};
			changeRR[] = {0,0, 0,0};
			changeSPo2[] = {0,0};
		};
		class causeSymptom {
			class Bleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.05;
				perAdd = 0.04;
				repeat = -1;
			};
			class InternalBleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.05;
				perAdd = 0.08;
				repeat = -1;
			};
			class Unconsciousness {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.05;
				perAdd = 0.10;
				repeat = 0.5;
			};
		};
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
			class Headache {
				addPart = "head";
				type = "add";
				severityThreshold = 0;
				perAdd = 0.02;
				repeat = -1;
			};
		};
	};
	class Dislocations: SysmptomBase {
		selections[] = {"leftarm", "rightarm", "leftleg", "rightleg"};
		visableLevel = 0.5;
		visableValue[] = {0,1};
		class details {
			displayName = "脱臼";
			displayDesc = "脱臼不会致命，在紧急情况下应最后处理";
			type = "Sysmptom";
		};
	};

	// 其他
	class ArterialBleeding: SysmptomBase {
		visableLevel = 1;
		visableValue[] = {0,1};
		class details {
			displayName = "动脉破裂";
			displayDesc = "动脉破裂是非常危险的，需要尽快进行急救";
			type = "Sysmptom";
		};
	};
	class ForeignBodies: SysmptomBase {
		visableLevel = 0.75;
		visableValue[] = {0,1};
		class details {
			displayName = "异物";
			displayDesc = "异物往往是在交火或被卷入爆炸后获得的";
			type = "Sysmptom";
		};
		class causeSymptom {
			class ArterialBleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.2;
				perAdd = 0.015;
				repeat = 0.5;
			};
		};
	};

// 伤口
	class WoundBase: SymptomBase {
		visableLevel = 0;
		visableValue[] = {0,10};
		maxSeverity = 2;
		class details {
			displayName = "默认伤口";
			displayDesc = "默认伤口描述";
			type = "Wound";
			mutilate = 1;
		};
	};
	class WoundInternal: WoundBase {
		visableValue[] = {30,100};
		class details {
			displayName = "深层组织损伤";
			displayDesc = "患者皮下组织受到严重伤害";
			mutilate = 0.2;
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
				perAdd = 1.5;
				repeat = -1;
			};
			class ArterialBleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.8;
				perAdd = 0.015;
				repeat = 0.5;
			};
		};
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
				perAdd = 1.5;
				repeat = -1;
			};
			class ArterialBleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.8;
				perAdd = 0.015;
				repeat = 0.5;
			};
		};
		class reduceSymptom {};
	};
	class WoundAvulsion: WoundBase {
		class details {
			displayName = "撕脱伤";
			displayDesc = "皮肤与皮下组织、软组织或骨骼剥离";
			mutilate = 1.2;
		};
		class causeSymptom {
			class Bleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.10;
				perAdd = 0.02;
				repeat = -1;
			};
			class ArterialBleeding {
				addPart = "_SAME_";
				type = "add";
				severityThreshold = 0.8;
				perAdd = 0.015;
				repeat = 0.5;
			};
		};
		class reduceSymptom {};
	};
};
