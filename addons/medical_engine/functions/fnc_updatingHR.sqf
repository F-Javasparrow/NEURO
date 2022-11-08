#include "script_component.hpp"
params["_unit", "_tragetHR", "_changeHR"];

private _unitHR = GETHR(_unit);
private _HR = _unitHR;

if((_unitHR - DEFAULT_HR) * _tragetHR > 0 ) then {
	if(abs _tragetHR > abs(_unitHR - DEFAULT_HR)) then {
		_HR = 0 max (DEFAULT_HR + _tragetHR);
	};
} else {_HR = 0 max (_unitHR + _tragetHR)};

_HR = 0 max (_HR + _changeHR);

SETHR_T(_unit,_HR);

_HR;