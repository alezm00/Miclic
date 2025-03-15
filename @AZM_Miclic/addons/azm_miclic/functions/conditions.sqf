AZM_miclic_actionCondition_canDeploy = {
    !((vehicle ACE_player) getVariable ["AZM_miclic_var_isLaunching",false]) &&
    !((vehicle ACE_player) getVariable ["AZM_miclic_var_readyToDetonate",false]) &&
    !((vehicle ACE_player) getVariable ["AZM_miclic_var_isDetonating", false])
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
