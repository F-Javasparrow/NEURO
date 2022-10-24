#include "script_component.hpp"
params ["_unit", "_type", "_data", "_data2"];

private _symptomInfo = _unit getVariable [QEGVAR(medical,symptomInfo),[]];

switch(toLower _type) do {
	case"class": {
		_symptomClass = _data;
		if(isNil "_data2") then {_allSymptom = false} else {_allSymptom = _data2};
		
		while{true} do {
			_index = _symptomInfo find _data;
			_symptomInfo deleteAt _index;

			if!(_allSymptom || _index != -1) then {break};
		};
	};
	case"part": {

	};
};

_unit setVariable [QEGVAR(medical,symptomInfo), _symptomInfo];
_symptomInfo;