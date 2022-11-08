class CfgWeapons {
	class CBA_MiscItem;
	class CBA_MiscItem_ItemInfo;

	class Neuro_ItemBase: CBA_MiscItem {
		author = "Kal'tsitly";
		displayName = "";
		picture = "";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 1;
		};
	};

	class Neuro_Dopamine: Neuro_ItemBase {
		scope = 2;
		displayName = "多巴胺";
	};
	class Neuro_Epinephrine: Neuro_ItemBase {
		scope = 2;
		displayName = "肾上腺素";
	};
	class Neuro_Norepinephrine: Neuro_ItemBase {
		scope = 2;
		displayName = "去甲肾上腺素";
	};
	class Neuro_Nikethamide: Neuro_ItemBase {
		scope = 2;
		displayName = "尼可刹米";
	};
	class Neuro_Lidocaine: Neuro_ItemBase {
		scope = 2;
		displayName = "利多卡因";
	};
	class Neuro_Morphine: Neuro_ItemBase {
		scope = 2;
		displayName = "吗啡";
	};
};