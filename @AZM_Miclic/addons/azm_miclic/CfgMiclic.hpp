
class AZM_miclic_config {
	bagClass = "Land_Sleeping_bag_folded_F";
	bagVectorDIR[] = {0,-0.5,0.75};
	bagVectorUP[] = {0,-0.75,-0.5};
    ropeAddSafety = 30; //the script will add this to the rope length for safety reasons
    explosionSpeed = 0.25; //speed of the explosion

	class AZM_miclic_vehiclesClasses {
		class BaseConfig {
			ropeStartPosition[] = {0,1,0};
			bagLaunchPoint[] = {0,1,0};
			rounds = 2;
            ropeLength = 100; //the script will add 30 to this for safety reasons
	        explosionType = "BombCluster_03_Ammo_F"; //explosion type [IEDUrbanBig_Remote_Ammo,Bo_GBU12_LGB]
		};
		// Vanilla
		class B_APC_Tracked_01_CRV_F : BaseConfig {
			ropeStartPosition[] = {1.649,-2.91,-0.23};
			bagLaunchPoint[] = {1.649,-2.91,-0.23};
			rounds = 2;
		};
		class B_APC_Tracked_01_rcws_F:B_APC_Tracked_01_CRV_F {};




		//rhs
		class rhsusf_M1230_M2_usarmy_d: BaseConfig {
			ropeStartPosition[] = {-0.5,-2.1,-0.1};
			bagLaunchPoint[] = {-0.5,-2.1,-0.1};
		};
		class rhsusf_M1230_M2_usarmy_wd: rhsusf_M1230_M2_usarmy_d {};

	};
};
