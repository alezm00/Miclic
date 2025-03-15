



AZM_miclic_prepareLaunch = {

	private _vehicle = vehicle ACE_player;

	if (_vehicle getVariable ["AZM_miclic_var_isLaunching",false]) exitWith {};

	private _vehicleConfig = [_vehicle] call AZM_miclic_getVehicleConfig;

	if ((_vehicleConfig select 0) in ["Error missing input","Error not found"]) exitWith {[_vehicleConfig] call AZM_miclic_hint;};


	_vehicle setVariable ["AZM_miclic_var_isLaunching",true,true];

	private _rounds = _vehicleConfig param [2,2];

	private _ammo = _vehicle getVariable ["AZM_miclic_var_ammo",_rounds];

	if (_ammo < 1) exitWith {["No ammo left"] call AZM_miclic_hint;};

    ["Launching..."] call AZM_miclic_hint;

	[_vehicle,_vehicleConfig] spawn AZM_miclic_RopeGenerator;
};


AZM_miclic_RopeGenerator = {

	params ["_vehicle","_vehicleConfig"];

	_vehicleConfig params [
		"_ropeStartPosition",
		"_bagLaunchPoint",
		"_rounds",
		"_ropeLength",
		"_explosionType"
	];

    _vehicle setVariable ["AZM_miclic_var_ammo",(_vehicle getVariable ["AZM_miclic_var_ammo", _rounds]) - 1,true];




	private _bag = createVehicle [getText(configFile >> "AZM_miclic_config" >> "bagClass"), (getpos ACE_player) vectorAdd [0,0,-50], [], 0, "CAN_COLLIDE"];

	_bag attachTo [_vehicle,_bagLaunchPoint];

	private _dir = getArray(configFile >> "AZM_miclic_config" >> "bagVectorDIR");
	private _up = getArray(configFile >> "AZM_miclic_config" >> "bagVectorUP");
	_bag setVectorDirAndUp [_dir,_up];

	sleep 3;

	detach _bag;
	private _rope = ropeCreate [_vehicle, _ropeStartPosition, (_ropeLength + (missionNamespace getVariable ["AZM_miclic_var_ropeAddSafety",30]))];
	[_bag,[0,0,0],[0,0,-1]] ropeAttachTo _rope;

	private _light = "#lightpoint" createVehicle [0,0,0];
	[_light,_bag] remoteExec ["AZM_miclic_Light",0,true];

	private _particle = createVehicle ["#particlesource", (getpos ACE_player) vectorAdd [0,0,-50], [], 0, "CAN_COLLIDE"];
	_particle setParticleClass "missile1";
	_particle attachTo [_bag,[0,0,0.5]];

	_bag setVelocityModelSpace [0,30,20];
	playSound3D ["A3\Sounds_F\weapons\Rockets\missile_1.wss", _vehicle];


	_vehicle setVariable ["AZM_miclic_var_rope", _rope, true];
	_vehicle setVariable ["AZM_miclic_var_bag", _bag, true];
	_vehicle setVariable ["AZM_miclic_var_vehicleConfig", _vehicleConfig, true];

	sleep 2;

	deleteVehicle _particle;
	deleteVehicle _light;

	_vehicle setVariable ["AZM_miclic_var_readyToDetonate",true,true];



    ["Deployed, ready for detonation"] call AZM_miclic_hint;
};




AZM_miclic_detonate = {
	private _vehicle = vehicle ACE_player;

	if (!(_vehicle getVariable ["AZM_miclic_var_isLaunching", false])) exitWith {["Error not launching"] call AZM_miclic_hint;};
	if (!(_vehicle getVariable ["AZM_miclic_var_readyToDetonate", false])) exitWith {["Error not ready to detonate"] call AZM_miclic_hint;};

	private _vehicleConfig = _vehicle getVariable ["AZM_miclic_var_vehicleConfig",[_vehicle] call AZM_miclic_getVehicleConfig];

	_vehicleConfig params [
		"_ropeStartPosition",
		"_bagLaunchPoint",
		"_rounds",
		"_ropeLength",
		"_explosionType"
	];

	_vehicle setVariable ["AZM_miclic_var_isDetonating",true,true];

	private _debug = [];
	private _rope = _vehicle getVariable ["AZM_miclic_var_rope",objNull];
	if (isNull _rope) exitWith {["Error no rope"]};

	_rope enableSimulationGlobal false;

	for "_i" from (ropeLength _rope) to 20 step -5 do {
		private _ropeEnd = ropeEndPosition _rope;
		private _temp = createVehicle [_explosionType, _ropeEnd select 1, [], 0, "CAN_COLLIDE"];
		[_ropeEnd select 1] call AZM_miclic_WallHandler;
		_temp setDamage 1;

		ropeCut [_rope,ropeLength _rope-5];

		sleep (missionNamespace getVariable ["AZM_miclic_var_explosionSpeed", 0.25]);

		_debug pushBack (ropeLength _rope);

		if (ropeLength _rope < (missionNamespace getVariable ["AZM_miclic_var_ropeAddSafety", 30])) exitWith {};
	};

	_rope enableSimulationGlobal true;

	hint (_debug joinString "\n");

	sleep 1;

	_vehicle setVariable ["AZM_miclic_var_readyToDetonate",false,true];
	_vehicle setVariable ["AZM_miclic_var_isLaunching",false,true];

	_vehicle setVariable ["AZM_miclic_var_isDetonating",false,true];
    ropeDestroy _rope;
	deleteVehicle (_vehicle getVariable ["AZM_miclic_var_bag",objNull]);

    ["Explosion!"] call AZM_miclic_hint;
};



AZM_miclic_cut = {
	private _vehicle = vehicle ACE_player;
	if (!(_vehicle getVariable ["AZM_miclic_var_isLaunching", false])) exitWith {["Error not launching"] call AZM_miclic_hint;};
	if (!(_vehicle getVariable ["AZM_miclic_var_readyToDetonate", false])) exitWith {["Error not ready to detonate"] call AZM_miclic_hint;};

	ropeDestroy (_vehicle getVariable ["AZM_miclic_var_rope",objNull]);
	deleteVehicle (_vehicle getVariable ["AZM_miclic_var_bag",objNull]);

	_vehicle setVariable ["AZM_miclic_var_readyToDetonate",false,true];
	_vehicle setVariable ["AZM_miclic_var_isLaunching",false,true];
	_vehicle setVariable ["AZM_miclic_var_rope", objNull, true];
	_vehicle setVariable ["AZM_miclic_var_bag", objNull, true];

    ["Line cut"] call AZM_miclic_hint;
};


