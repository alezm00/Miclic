class CfgPatches {
    class azm_miclic_module {
        author = "Alezm";
        name = "AZM Miclic Module";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"cba_main","ace_main","azm_miclic"};
        version = 1.0;
        authors[] = {"Alezm"};
    };
};


class CfgFactionClasses {   //what the hell is this needed for again?
    class NO_CATEGORY;
    class azm_miclic: NO_CATEGORY {
        displayName = "AZM Miclic Modules";
        priority = 2;
        side = 7;
    };
};

class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class Edit;					// Default edit box (i.e. text input field)
			class Combo;				// Default combo box (i.e. drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
		// Description base class
		class ModuleDescription;
	};

	class azmModuleBase: Module_F {
		author = "Alezm";
		category = "azm_miclic";
	};

	class azmModule_rearm: azmModuleBase {
		scope = 2; //editor visible
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0; //wait till all synched triggers are active

		displayName = "Miclic Rearm Point";
		function = "AZM_miclic_rearmModule"; // Name of function triggered once conditions are met
		class Attributes: AttributesBase { //GUI to define input parameters to function
			class ModuleDescription: ModuleDescription {};
		};
		class ModuleDescription: ModuleDescription {
			description = "Synchronized objects become Miclic rearm points";
		};
	};
};
