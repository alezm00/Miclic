class CfgPatches {
    class azm_miclic_trebuchet_compat {
        author = "Alezm";
        name = "azm_miclic_trebuchet_compat";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"cba_main","ace_main","azm_miclic","OPTRE_Vehicles_Warthog"};
        skipWhenMissingDependencies = 1;
        version = 1.0;
        authors[] = {"Alezm"};
    };
};





class AZM_miclic_config {
	class AZM_miclic_vehiclesClasses {
		class BaseConfig;
        class trebuchetConfig: BaseConfig {
            rounds = 3;
            // ropeLength = 100;
            // explosionType = "SatchelCharge_F";
            // explosionType = "DemoCharge_Remote_Ammo_Scripted";
        };
        // class BaseConfig {
		// 	ropeStartPosition[] = {0,1,0};
		// 	bagLaunchPoint[] = {0,1,0};
		// 	rounds = 2;
        //     ropeLength = 100; //the script will add 30 to this for safety reasons
	    //     explosionType = "IEDLandSmall_F"; //explosion type [IEDUrbanBig_Remote_Ammo,Bo_GBU12_LGB,IEDLandSmall_F,BombCluster_03_Ammo_F]
		// };
        class OPTRE_M914_RV: trebuchetConfig {
            ropeStartPosition[] = {0,-1.77,-0.175};
			bagLaunchPoint[] = {0,-1.77,0};
        };

	};
};






