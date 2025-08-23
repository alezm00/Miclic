
AZM_miclic_addRearmAction = {
    params [
        ["_object", objNull, [objNull]],
        ["_actionPath",[],[[]]],//"ACE_MainActions"
        ["_actionCoordinates",[0,0,1],[[]]]
    ];
    if (isNull _object) exitWith {false};

    _insertChildren = {
        params ["_target", "_player", "_params"];

        private _vehicleList = (nearestObjects [_player, ["Car", "Tank", "LandVehicle"], 20]) select {
            (typeOf _x) in (missionNamespace getVariable ["AZM_miclic_var_vehiclesClassLists",[]])
        };


        // Add children to this action
        private _actions = [];
        {
            //AZM_miclic_rearmVehicle
            private _actionName = format ["Rearm: %1 (%2m)",getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName"), floor (_x distance _player)];
            private _action = [
                _x,
                _actionName,
                getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "Icon"),
                AZM_miclic_rearmVehicle,
                {true},
                {},
                _x
            ] call ace_interact_menu_fnc_createAction;
            _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
        } forEach _vehicleList;

        _actions
    };
    private _action = ["AZM_Miclic_rearm","Miclic rearm","",{true},{true},_insertChildren,[], _actionCoordinates, 15] call ace_interact_menu_fnc_createAction;
    [_object, 0, _actionPath, _action] call ace_interact_menu_fnc_addActionToObject;
};



AZM_miclic_rearmModule = {
    params [
        ["_logic", objNull, [objNull]],		// Argument 0 is module logic
        ["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
        ["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
    ];

    // Module specific behavior. Function can extract arguments from logic and use them.
    if (_activated) then {
        {
            [_x] call AZM_miclic_addRearmAction;
        } forEach (synchronizedObjects _logic);
    };
    // Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
    true;

};


AZM_miclic_rearmVehicle = {
    params ["_object","_player","_vehicle"];

    private _progressText = format ["Rearming: %1", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")];

    [_progressText, AZM_CBAOptionMiclic, {alive player && alive (_this#0#2) && !(isEngineOn (_this#0#2))}, {

        diag_log str _this;
        // [
        //     [
        //         3fe6468f400# 163959: slingload_01_ammo_f.p3d B_Slingload_01_Ammo_F,
        //         B Alpha 1-1:1 ({9GU}Lt.Alezm),
        //         B Alpha 1-2:3
        //     ],
        //     true,
        //     5,
        //     5,
        //     0
        // ]
        (_this select 0) params ["_object","_player","_vehicle"];

        private _vehicleConfig = [_vehicle] call AZM_miclic_getVehicleConfig;
        private _rounds = _vehicleConfig param [2,2];

        _vehicle setVariable ["AZM_miclic_var_ammo",_rounds,true];
        ["Miclic Rearmed"] call AZM_miclic_hint

    }, {
        //abort
        diag_log str _this;
        //[[3fe6468f400# 163959: slingload_01_ammo_f.p3d B_Slingload_01_Ammo_F,B Alpha 1-1:1 ({9GU}Lt.Alezm),B Alpha 1-2:3],false,0.722,5,1]
        (_this select 0) params ["_object","_player","_vehicle"];
        if (isEngineOn _vehicle) then {
            ["Rearm aborted<br/><br/>Turn off engine"] call AZM_miclic_hint;
        } else {
            ["Rearm aborted"] call AZM_miclic_hint;
        };
    },
    _this
    ] call CBA_fnc_progressBar;

};
