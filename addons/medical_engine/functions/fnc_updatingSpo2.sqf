#include "script_component.hpp"
params["_unit", "_tragetSpo2", "_changeSpo2"];

private _unitSpo2 = GETSPO2(_unit);
private _spo2 = _unitSpo2;

if((_unitSpo2 - DEFAULT_SPO2) * _tragetSpo2 > 0 ) then {
	if(abs _tragetSpo2 > abs(_unitSpo2 - DEFAULT_SPO2)) then {
		_spo2 = 0 max (DEFAULT_SPO2 + _tragetSpo2);
	};
} else {_spo2 = 0 max (_unitSpo2 + _tragetSpo2)};

_HR = 0 max (_spo2 + _changeSpo2);

SETSPO2_T(_unit,_spo2);

_spo2;