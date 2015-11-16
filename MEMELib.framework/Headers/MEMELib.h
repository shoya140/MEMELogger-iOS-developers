//
//  MEMELib.h
//  
//
//  Created by JINS MEME on 8/11/14.
//  Copyright (c) 2014 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "MEMERealTimeData.h"

FOUNDATION_EXPORT double MEMEVersionNumber;
FOUNDATION_EXPORT const unsigned char MEMEVersionString[];

// MEME Device Type
typedef enum {
    ES  = 0,
    MT = 1,
} MEMEType;

// Error Code
typedef enum {
    MEME_OK                 = 0,
    MEME_ERROR              = 1, // Misc Error
    MEME_ERROR_SDK_AUTH     = 2, // SDK Auth Error
    MEME_ERROR_APP_AUTH     = 3, // App Auth Error
    MEME_ERROR_CONNECTION   = 4, // No Connection
    MEME_DEVICE_INVALID     = 5, // Invalid Device
    MEME_CMD_INVALID        = 6, // Invalid Command
    MEME_ERROR_FW_CHECK     = 7, // FW Version Error
    MEME_ERROR_BL_OFF       = 8  // Bluetooth is Off
} MEMEStatus;


typedef struct {
    int eventCode;
    BOOL commandResult;
} MEMEResponse;

// Calibration Status
typedef enum {
    CALIB_NOT_FINISHED      = 0,
    CALIB_BODY_FINISHED     = 1,
    CALIB_EYE_FINISHED      = 2,
    CALIB_BOTH_FINISHED     = 3,
} MEMECalibStatus;


@protocol MEMELibDelegate <NSObject>

@optional
- (void) memeAppAuthorized: (MEMEStatus) status;
- (void) memeFirmwareAuthorized: (MEMEStatus) status;

- (void) memePeripheralFound: (CBPeripheral *) peripheral withDeviceAddress: (NSString *) address;

- (void) memePeripheralConnected: (CBPeripheral *)peripheral;
- (void) memePeripheralDisconnected: (CBPeripheral *)peripheral;

- (void) memeRealTimeModeDataReceived: (MEMERealTimeData *) data;

- (void) memeCommandResponse: (MEMEResponse) response;

@end


@interface MEMELib : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (weak, nonatomic)   id<MEMELibDelegate> delegate;

@property (readonly) BOOL               isConnected;
@property (readonly) BOOL               isDataReceiving;
@property (readonly) MEMECalibStatus    isCalibrated;

+ (MEMELib *)sharedInstance;

#pragma mark AUTH

+ (void) setAppClientId: (NSString *) clientId clientSecret: (NSString *) clientSecret;

#pragma mark CONNECTION

- (MEMEStatus) startScanningPeripherals;
- (MEMEStatus) stopScanningPeripherals;

- (MEMEStatus) connectPeripheral:(CBPeripheral *)peripheral;
- (MEMEStatus) disconnectPeripheral;

- (NSArray *) getConnectedByOthers;

#pragma mark DEVICE

- (MEMEStatus) startDataReport;
- (MEMEStatus) stopDataReport;

#pragma mark DEVICE INFO

- (NSString *) getSDKVersion;
- (NSString *) getFWVersion;
- (UInt8) getHWVersion;
- (int) getConnectedDeviceType;
- (int) getConnectedDeviceSubType;

@end
