AZM_miclic_Light = {
	_light  = _this select 0;
	_bag = _this select 1;
	_light setLightBrightness 1;
	_light setLightAmbient [0.9,0.9,0.6];
	_light setLightColor [0.9,0.9,0.6];
	_light lightAttachObject [_bag, [0,0,0.5]];
};

AZM_miclic_WallHandler = {
    params [
        ["_pos",[0,0,0],[[]]],
        ["_range",20,[0]]
    ];

    _walls = nearestTerrainObjects [_pos,["FENCE","WALL","TREE", "SMALL TREE", "BUSH"],_range];
    _walls = _walls apply {
        _damage = if (_x distance _pos > (_range/2)) then {0.9} else {1};
        _x setDamage _damage;
        _damage;
    };
    _walls
};


AZM_miclic_getVehicleConfig = {
	params [
		["_vehicle","",["",objNull]]
	];


	if ((typename _vehicle) == "OBJECT") then {
		_vehicle = typeOf _vehicle;
	};
	if (_vehicle == "") exitWith {["Error missing input"] call AZM_miclic_hint;};
	_config = "configName _x == _vehicle" configClasses (configFile >> "AZM_miclic_config" >> "AZM_miclic_vehiclesClasses"); //TODO replace configFile to configFile
	if (count _config == 0) exitWith {["Error not found"] call AZM_miclic_hint;};

	[
		getArray((_config select 0) >> "ropeStartPosition"),
		getArray((_config select 0) >> "bagLaunchPoint"),
		getNumber((_config select 0) >> "rounds"),
		getNumber((_config select 0) >> "ropeLength"),
		getText((_config select 0) >> "explosionType")
	]
};


AZM_miclic_hint = {
    params [
        ["_text","Error",["",[],true,0]]
    ];

    [["AZM Miclic", 2, [1, 1, 0, 1]], [_text], true] call CBA_fnc_notify;
};
