

missionNamespace setVariable ["AZM_miclic_var_ropeAddSafety", getNumber (ConfigFile >> "AZM_miclic_config" >> "ropeAddSafety")];
missionNamespace setVariable ["AZM_miclic_var_explosionSpeed", getNumber (ConfigFile >> "AZM_miclic_config" >> "explosionSpeed")];



// pregenerate the list of vehicles classes to use it in condition so i dont have to call the config file every time
private _vehiclesClassLists = "true" configClasses (configFile >> "AZM_miclic_config" >> "AZM_miclic_vehiclesClasses");
_vehiclesClassLists = _vehiclesClassLists apply {
    configName _x;
};
missionNamespace setVariable ["AZM_miclic_var_vehiclesClassLists", _vehiclesClassLists];


["AZM_CBAOptionMiclic", "TIME",  ["Rearm time", "AZM Miclic rearm time"], "AZM Miclic", [1, 60, 5], 1] call CBA_fnc_addSetting;
