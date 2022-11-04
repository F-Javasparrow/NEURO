#include "script_component.hpp"

private _unitHR = GETHR(_unit);
private _unitRR = GETRR(_unit);
private _unitSpO2 = GETSPO2(_unit);
private _unitBloodVolume =  GETBLOODVOLUME(_unit);

// 心率
switch(true) do {
	case(_unitHR <= 0):{
		[QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.1]]] call CBA_fnc_localEvent;
	};
	case(_unitHR <= 10): {
		[QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.05]]] call CBA_fnc_localEvent;
	};
	case(_unitHR <= 20): {
		[QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.025]]] call CBA_fnc_localEvent;
	};
	case(_unitHR >= 200): {
		[QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.05]]] call CBA_fnc_localEvent;
	};
};

// 血压
switch(true) do {
	case(_unitRR#0 <= 0): {};
};

// 血氧
switch(true) do {
	case(_unitSpO2 <= 0): {
		// [QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.05]]] call CBA_fnc_localEvent;
	};
	case(_unitSpO2 <= 10): {
		// [QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.05]]] call CBA_fnc_localEvent;
	};
	case(_unitSpO2 <= 20): {
		// [QEGVAR(medical,addSymptom), [_unit, "IrregularHeartbeat", "torso", ["add", 0.05]]] call CBA_fnc_localEvent;
	};
};