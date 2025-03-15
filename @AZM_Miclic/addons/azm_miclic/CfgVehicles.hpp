
#define ACTIONS class ACE_SelfActions { \
            class AZM_Miclic_actions { \
                displayName = "Miclic"; \
                condition = "[] call AZM_miclic_actionCondition_main"; \
                exceptions[] =  {"isNotDragging", "isNotSwimming", "notOnMap", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"}; \
                modifierFunction = "call AZM_miclic_actionCondition_canDeployModifier"; \
                statement = "true;"; \
                icon = ""; \
                showDisabled = 0; \
                class AZM_Miclic_deploy { \
                    displayName = "Deploy MICLIC"; \
                    condition = "[] call AZM_miclic_actionCondition_canDeploy"; \
                    icon = ""; \
                    statement = "[] call AZM_miclic_prepareLaunch"; \
                    showDisabled = 0; \
                }; \
                class AZM_Miclic_Detonate { \
                    displayName = "Detonate MICLIC"; \
                    condition = "[] call AZM_miclic_actionCondition_canDetonate"; \
                    icon = ""; \
                    statement = "[] spawn AZM_miclic_detonate"; \
                    showDisabled = 0; \
                }; \
                class AZM_Miclic_cut { \
                    displayName = "Cut MICLIC"; \
                    condition = "[] call AZM_miclic_actionCondition_canCut"; \
                    icon = ""; \
                    statement = "[] call AZM_miclic_cut"; \
                    showDisabled = 0; \
                }; \
            }; \
        }; \


class CfgVehicles {

    //["All","AllVehicles","Land","LandVehicle","Tank","Tank_F","APC_Tracked_01_base_F","B_APC_Tracked_01_base_F"]

    // class Land;
    class LandVehicle;
    class Tank: LandVehicle {
        ACTIONS
    };
};







