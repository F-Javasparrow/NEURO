class Neuro_Medical_Wounds {
	class woundHandler {
		ADDON = QFUNC(woundHandlerBase);
	};

	class bullet {
		wound = [
			["Wound_Gunshot", 80, 50],
			["Wound_Lacerations", 40, 50]
		];
		_selection = ALL_MAINBODYPART;

		class _woundHandlers: woundHandler{};
	};
	class explosive {
		wound = [
			["Wound_Gunshot", 30, 50],
			["Wound_Lacerations", 80, 65]
		];
		_selection = ALL_MAINBODYPART;

		class _woundHandlers: woundHandler{};
	};
};