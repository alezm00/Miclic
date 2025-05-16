class CfgPatches {
    class azm_miclic_rhsusaf_compat {
        author = "Alezm";
        name = "azm_miclic_rhsusaf_compat";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"cba_main","ace_main","azm_miclic","rhsusf_c_Caiman"};
        skipWhenMissingDependencies = 1;
        version = 1.0;
        authors[] = {"Alezm"};
    };
};





class AZM_miclic_config {
	class AZM_miclic_vehiclesClasses {
		class BaseConfig;
        class rhsConfig: BaseConfig {
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
        class rhsusf_M1220_M2_usarmy_d: rhsConfig {
            ropeStartPosition[] = {-0.515,-2.747,0.471};
			bagLaunchPoint[] = {-0.515,-2.747,0.638};
        };
        class rhsusf_M1220_MK19_usarmy_d: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_M153_MK19_usarmy_d: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_M153_M2_usarmy_d: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_usarmy_d: rhsusf_M1220_M2_usarmy_d {};

        class rhsusf_M1220_M2_usarmy_wd: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_MK19_usarmy_wd: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_M153_MK19_usarmy_wd: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_M153_M2_usarmy_wd: rhsusf_M1220_M2_usarmy_d {};
        class rhsusf_M1220_usarmy_wd: rhsusf_M1220_M2_usarmy_d {};




        // class : rhsConfig {
        //     ropeStartPosition[] = {};
		// 	bagLaunchPoint[] = {};
        // };


		//rhs
		class rhsusf_M1230_M2_usarmy_d: rhsConfig {
			ropeStartPosition[] = {-0.714,-1.842,0.217};
			bagLaunchPoint[] = {-0.714,-1.842,0.382};
		};
        class rhsusf_M1230_MK19_usarmy_d : rhsusf_M1230_M2_usarmy_d {};
		class rhsusf_M1230_M2_usarmy_wd: rhsusf_M1230_M2_usarmy_d {};
        class rhsusf_M1230_MK19_usarmy_wd: rhsusf_M1230_M2_usarmy_d {};
	};
};






