class Neuro_Medical_Treatments {

	class MedicationBase {
		displayName = "默认药物";
		displayDesc = "默认药物描述";
		selections[] = {"head", "torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 600};
		efficiency = 0.2;
		class details {	
			type = "Medication";
			changeHR[] = {0,0};
			changeRR[] = {0,0,0,0};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};

	class Dopamine: MedicationBase {
		displayName = "多巴胺";
		displayDesc = "多巴胺描述";
		selections[] = {"torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 600};
		efficiency = 0.25;
		class details {
			type = "Medication";
			changeHR[] = {5,10};
			changeRR[] = {0,0,0,0};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
	class Epinephrine: MedicationBase {
		displayName = "肾上腺素";
		displayDesc = "肾上腺素描述";
		selections[] = {"torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 600};
		efficiency = 0.25;
		class details {
			type = "Medication";
			changeHR[] = {10,25};
			changeRR[] = {0,0,0,0};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
	class Norepinephrine: MedicationBase {
		displayName = "去甲肾上腺素";
		displayDesc = "去甲肾上腺素描述";
		selections[] = {"torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 600};
		efficiency = 0.25;
		class details {
			type = "Medication";
			changeHR[] = {5,15};
			changeRR[] = {5,15,5,15};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
	class Nikethamide: MedicationBase {
		displayName = "尼可刹米";
		displayDesc = "尼可刹米描述";
		selections[] = {"torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 450};
		efficiency = 0.25;
		class details {
			type = "Medication";
			changeHR[] = {5,15};
			changeRR[] = {5,15,5,15};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
	class Lidocaine: MedicationBase {
		displayName = "利多卡因";
		displayDesc = "利多卡因描述";
		selections[] = {"torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 450};
		efficiency = 0.25;
		class details {
			type = "Medication";
			changeHR[] = {0,0};
			changeRR[] = {0,0,0,0};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
	class Morphine: MedicationBase {
		displayName = "吗啡";
		displayDesc = "吗啡描述";
		selections[] = {"torso", "ventral", "leftarm", "rightarm", "leftleg", "rightleg"};
		timeInSystem[] = {10, 600};
		efficiency = 0.25;
		class details {
			type = "Medication";
			changeHR[] = {-5,-15};
			changeRR[] = {0,0,0,0};
			changeSPo2[] = {0,0};
			changeViscosity[] = {0,0};
		};
		class causeSymptom {};
		class reduceSymptom {};
	};
};