
class AZM_miclic_config {
	// bagClass = "Land_Sleeping_bag_folded_F";
	// bagVectorDIR[] = {0,-0.5,0.75};
	// bagVectorUP[] = {0,-0.75,-0.5};
	bagClass = "Land_RotorCoversBag_01_F";
	bagVectorDIR[] = {0, -0.5, 0.75};
	bagVectorUP[] = {0, -0.75, -0.5};
    ropeAddSafety = 30; //the script will add this to the rope length for safety reasons
    explosionSpeed = 0.25; //speed of the explosion

	class AZM_miclic_vehiclesClasses {



		class BaseConfig {
			ropeStartPosition[] = {0,1,0};
			bagLaunchPoint[] = {0,1,0};
			rounds = 2;
            ropeLength = 110; //the script will add 30 to this for safety reasons
	        explosionType = "DemoCharge_Remote_Ammo_Scripted"; //explosion type [IEDUrbanBig_Remote_Ammo,Bo_GBU12_LGB,IEDLandSmall_F,BombCluster_03_Ammo_F]
		};
		// Vanilla
		class B_APC_Tracked_01_CRV_F: BaseConfig {
			ropeStartPosition[] = {1.3,-4,-0.2};
			bagLaunchPoint[] = {1.3,-4,0};
		};
		class B_APC_Tracked_01_rcws_F: B_APC_Tracked_01_CRV_F {};
		class B_T_APC_Tracked_01_rcws_F: B_APC_Tracked_01_CRV_F {};
		class B_T_APC_Tracked_01_CRV_F: B_APC_Tracked_01_CRV_F {};


        class B_APC_Wheeled_01_cannon_F: BaseConfig {

            ropeStartPosition[] = {-0.022,-3.902,-0.023};
            bagLaunchPoint[] = {-0.022,-3.902,0.091};
        };
        class B_T_APC_Wheeled_01_cannon_F: B_APC_Wheeled_01_cannon_F {};


	};

};
