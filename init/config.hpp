class GMSAI_PlayerMessaging {
    GMSAI_useKillMessages = true;
    GMSAI_useKilledAIName = true; // when true, the name of the unit killed will be included in the kill message.
};
class GMSAI_blacklistedAreas {
    blacklistedAreas[] = {
        [[0,0,0],100]  //  Note that there is no comma after the last element in this array.
        };  //  add these as [position, radius]

};
class GMSAI_gearSettings {


    checkClassNames = true; // when true, class names listed in the configs will be checked against CfgVehicles, CfgWeapons, ets.
    GMSAI_useCfgPricingForLoadouts = true;
    GMSAI_maxPricePerItem = 1000;    
    blacklistedGear[] = {
    
    };    
};

