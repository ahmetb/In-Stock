//  ISModel.h
//  InStock
//  Created by Ahmet Alp Balkan on 10/26/13.

#define N(x) [NSNumber numberWithInteger:x]


/*
    ONLY ADD TO THE END OF ENUMS !!!!!!!!!!! <-----------
        ONLY ADD TO THE END OF ENUMS !!!!!!! <-----------
            ONLY ADD TO THE END OF ENUMS !!! <-----------
        ONLY ADD TO THE END OF ENUMS !!!!!!! <-----------
    ONLY ADD TO THE END OF ENUMS !!!!!!!!!!! <-----------
*/
 
typedef NS_ENUM(NSInteger, ISIdiom) {
    ISIdiomMobileDeviceCapacity = 0,
    ISIdiomMacBookScreenSize,
    ISIdiomMacMiniConfiguration,
    ISIdiomiMacConfiguration,
    ISIdiomMacProConfiguration,
    ISIdiomMacBookProConfiguration,
    ISIdiomMacBookAirConfiguration,
    ISIdiomiPhoneColor,
    ISIdiomiPadType,
    ISIdiomNetworkCarrier
};

typedef NS_ENUM(NSInteger, ISMobileDeviceCapacity) {
    ISMobileDeviceCapacity8GB = 0,
    ISMobileDeviceCapacity16GB,
    ISMobileDeviceCapacity32GB,
    ISMobileDeviceCapacity64GB,
    ISMobileDeviceCapacity128GB,
};

typedef NS_ENUM(NSInteger, ISMacBookScreenSize) {
    ISMacBookScreenSize11inch = 0,
    ISMacBookScreenSize13inch,
    ISMacBookScreenSize15inch
};

typedef NS_ENUM(NSInteger, ISMacMiniConfiguration) {
    ISMacMiniConfiguration2_5GHz = 0,
    ISMacMiniConfiguration2_3GHz,
    ISMacMiniConfiguration2_3GHzWithOsXServer
};

typedef NS_ENUM(NSInteger, ISiMacConfiguration) {
    ISiMacConfiguration21_5inch2_7GHz = 0,
    ISiMacConfiguration21_5inch2_9GHz,
    ISiMacConfiguration27_5inch3_2GHz,
    ISiMacConfiguration27_5inch3_4GHz
};

typedef NS_ENUM(NSInteger, ISMacBookProConfiguration) {
    ISMacBookProConfiguration2_4GHz_i5_4GBMemory_128GBDisk = 0,
    ISMacBookProConfiguration2_4GHz_i5_8GBMemory_256GBDisk,
    ISMacBookProConfiguration2_6GHz_i5_8GBMemory_512GBDisk,
    ISMacBookProConfiguration2_0GHz_i7_8GBMemory_256GBDisk,
    ISMacBookProConfiguration2_3GHz_i7_16GBMemory_512GBDisk
};


typedef NS_ENUM(NSInteger, ISMacBookAirConfiguration) {
    ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_128GBDisk = 0,
    ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_256GBDisk
};


typedef NS_ENUM(NSInteger, ISMacProConfiguration) {
    ISMacProConfiguration4Core = 0,
    ISMacProConfiguration6Core
};

typedef NS_ENUM(NSInteger, ISiPhoneColor) {
    ISiPhoneColorBlack = 0,
    ISiPhoneColorWhite,
    ISiPhoneColorSilver,
    ISiPhoneColorSpaceGray,
    ISiPhoneColorGold,
    ISiPhoneColorPink,
    ISiPhoneColorYellow,
    ISiPhoneColorBlue,
    ISiPhoneColorGreen
};

typedef NS_ENUM(NSInteger, ISiPadType) {
    ISiPadTypeWifi = 0,
    ISiPadTypeWifiCellular
};

typedef NS_ENUM(NSInteger, ISNetworkCarrier) {
    ISNetworkCarrierAtt = 0,
    ISNetworkCarrierSprint,
    ISNetworkCarrierVerizon,
    ISNetworkCarrierTmobileContractFree,
    ISNetworkCarrierUnlockedSimFree,
    ISNetworkCarrierTmobile
};

@interface ISIdioms : NSObject

+(NSString*)titleForIdiom:(ISIdiom)idiom;
+(NSString*)nameForOption:(NSInteger)option inIdiom:(ISIdiom)idiom;

@end