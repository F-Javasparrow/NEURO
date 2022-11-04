#include "script_component.hpp"
params["_unit", "_tragetHR"];

private _unitHR = GETHR(_unit);
private _HR = _unitHR;
		
private _tragetHR = (_tragetHR # 1 - _tragetHR # 0) * _severity + _tragetHR # 0;
if((_unitHR - DEFAULT_HR) * _tragetHR > 0 ) then {
	if(abs _tragetHR > abs(_unitHR - DEFAULT_HR)) then {
		_HR = 0 max (DEFAULT_HR + _tragetHR);
	};
} else {_HR = 0 max (_unitHR + _tragetHR)};

private _changeHR = _changeValue get "changeHR";
private _changeHR = (_changeHR # 1 - _changeHR # 0) * _severity + _changeHR # 0;
_HR = 0 max (_HR + _changeHR);

SETHR_T(_unit,_HR);

_HR;