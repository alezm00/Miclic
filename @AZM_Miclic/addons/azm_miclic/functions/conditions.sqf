AZM_miclic_actionCondition_canDeploy = {
    !(vehicle ACE_player) getVariable ["AZM_miclic_var_isLaunching",false] &&
    !(vehicle ACE_player) getVariable ["AZM_miclic_var_readyToDetonate",false] &&
    !(vehicle ACE_player) getVariable ["AZM_miclic_var_isDetonating", false]
};

AZM_miclic_actionCondition_canDeployModifier = {
    params ["_target", "_player", "_params", "_actionData"];

    private _vehicle = vehicle ACE_player;

    private _vehicleConfig = [_vehicle] call AZM_miclic_getVehicleConfig;
	_vehicleConfig params [
		"_ropeStartPosition",
		"_bagLaunchPoint",
		"_rounds",
		"_ropeLength",
		"_explosionType"
	];

    _actionData set [1, format ["Miclic  (Ammo: %1)", _vehicle getVariable ["AZM_miclic_var_ammo", _rounds]]];
};

AZM_miclic_actionCondition_canDetonate = {
    (vehicle ACE_player) getVariable ["AZM_miclic_var_readyToDetonate",false]
};
AZM_miclic_actionCondition_canCut = {
    (vehicle ACE_player) getVariable ["AZM_miclic_var_readyToDetonate",false]
};

AZM_miclic_actionCondition_main = {
    (typeOf(vehicle ACE_player)) in (missionNamespace getVariable ["AZM_miclic_var_vehiclesClassLists",[]]) &&
    (driver (vehicle ACE_player)) == ACE_player &&
    speed (vehicle ACE_player) < 1
};
/*












GEN_CONDITION = {
	player setUserActionText [
		(player getVariable ["GEN_actionid",-1]),
		(["<t color='#e74c3c'>",localize "STR_LAUNCH"," (",call GEN_Vehammo,")</t>"] joinString "")
	];
	if ((vehicle player) getVariable ["GEN_ammo",-1] != -1) then {
		player setUserActionText [
			(player getVariable ["GEN_actionid",-1]),
			(["<t color='#e74c3c'>",localize "STR_LAUNCH"," (",(vehicle player) getVariable ["GEN_ammo",([vehicle player] call GEN_FindVehConfig) select 2],")</t>"] joinString "")
		];
	};
	if (!isNull ((vehicle player) getVariable ["GEN_rope",objNull])) then {
		_extendcheck = {
			_rope = (vehicle player) getVariable ["GEN_rope",objNull];
			if (isNull _rope) exitWith {""};
			_maxlength = getNumber(configFile >> "GEN_miclic_config" >> "ropelength");
			_ropepos = (ropeEndPosition _rope select 1);
			if ((vehicle player) distance _ropepos < _maxlength) exitWith {[" (",localize "STR_NOT_EXTENDED",")"] joinString ""};
			"";
		};
		player setUserActionText [
			(player getVariable ["GEN_actionid",-1]),
			(["<t color='#e74c3c'>",localize "STR_DETONATE",call _extendcheck,"</t>"] joinString "")
		];
	};
	((driver (vehicle player)) == player) &&
	!(([vehicle player] call GEN_FindVehConfig) select 0 isEqualTo "Error") &&
	((vehicle player) getVariable ["GEN_ammo",1] != 0 || !isNull ((vehicle player) getVariable ["GEN_rope",objNull]))
};

GEN_CONDITION_CUT = {
	((driver (vehicle player)) == player) &&
	!(([vehicle player] call GEN_FindVehConfig) select 0 isEqualTo "Error") &&
	((vehicle player) getVariable ["GEN_ammo",1] != 0) &&
	!(isNull ((vehicle player) getVariable ["GEN_rope",objNull]))
};





GEN_actionHandler = { //(player getVariable ["GEN_actionid",-1])
	_actionid = player addAction [
		(["<t color='#e74c3c'>",localize "STR_LAUNCH"," (",call GEN_Vehammo,")</t>"] joinString ""),
		{
			[vehicle player] call GEN_Act;
		},
		[],
		1,
		false,
		false,
		"",
		"call GEN_CONDITION"
	];
	_actionid2 = player addAction [
		(["<t color='#e74c3c'>",localize "STR_CUTROPE","</t>"] joinString ""),
		{
			[vehicle player] call GEN_cut;
		},
		[],
		0,
		false,
		false,
		"",
		"call GEN_CONDITION_CUT"
	];
	player setVariable ["GEN_actionid",_actionid];
	player setVariable ["GEN_actionid2",_actionid2];
	[_actionid,_actionid2];
};
call GEN_actionHandler;
player addEventHandler ["Respawn",{call GEN_actionHandler}];
