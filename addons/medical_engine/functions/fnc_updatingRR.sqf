#include "script_component.hpp"
params["_unit", "_tragetRR", "_changeRR"];

private _unitRR = GETRR(_unit);
private _RR_Low = _unitRR # 0;
private _RR_High = _unitRR # 1;

if((_RR_Low - DEFAULT_RR_LOW) * _tragetRR # 0 > 0 ) then {
	if(abs _tragetRR # 0 > abs(_RR_Low - DEFAULT_RR_LOW)) then {
		_RR_Low = 0 max (DEFAULT_RR_LOW + _tragetRR # 0);
	};
} else {_RR_Low = 0 max (_RR_Low + _tragetRR # 0)};

if((_RR_High - DEFAULT_RR_HIGH) * _tragetRR # 1 > 0 ) then {
	if(abs _tragetRR # 1 > abs(_RR_High - DEFAULT_RR_HIGH)) then {
		_RR_High = _RR_Low max (DEFAULT_RR_HIGH + _tragetRR # 1);
	};
} else {_RR_High = _RR_Low max (_RR_High + _tragetRR # 1)};

_RR_Low = 0 max (_RR_Low + _changeRR # 0);
_RR_High = 0 max (_RR_High + _changeRR # 1);

SETRR_T(_unit,[ARR_2(_RR_Low,_RR_High)]);

[_RR_Low, _RR_High];