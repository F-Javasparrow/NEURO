#include "script_component.hpp"
params["_unit", "_tragetRR"];

private _unitRR = GETRR(_unit);
private _RR_Low = _unitRR # 0;
private _RR_High = _unitRR # 1;
		
private _tragetRR_Low  = (_tragetRR # 1 - _tragetRR # 0) * _severity + _tragetRR # 0;
private _tragetRR_High = (_tragetRR # 3 - _tragetRR # 2) * _severity + _tragetRR # 2;
if((_RR_Low - DEFAULT_RR_LOW) * _tragetRR_Low > 0 ) then {
	if(abs _tragetRR_Low > abs(_RR_Low - DEFAULT_RR_LOW)) then {
		_RR_Low = 0 max (DEFAULT_RR_LOW + _tragetRR_Low);
	};
} else {_RR_Low = 0 max (_RR_Low + _tragetRR_Low)};
if((_RR_High - DEFAULT_RR_HIGH) * _tragetRR_High > 0 ) then {
	if(abs _tragetRR_High > abs(_RR_High - DEFAULT_RR_HIGH)) then {
		_RR_High = _RR_Low max (DEFAULT_RR_HIGH + _tragetRR_High);
	};
} else {_RR_High = _RR_Low max (_RR_High + _tragetRR_High)};

private _changeRR = _changeValue get "changeRR";
private _changeRR_Low  = (_changeRR # 1 - _changeRR # 0) * _severity + _changeRR # 0;
private _changeRR_High = (_changeRR # 3 - _changeRR # 2) * _severity + _changeRR # 2;
_RR_Low = 0 max (_RR_Low + _changeRR_Low);
_RR_High = 0 max (_RR_High + _changeRR_High);

SETRR_T(_unit,[ARR_2(_RR_Low,_RR_High)]);

[_RR_Low, _RR_High];