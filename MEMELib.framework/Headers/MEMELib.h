//
//  MEMELib.h
//  
//
//  Created by JINS MEME on 8/11/14.
//  Copyright (c) 2014 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "MEMEStandardData.h"
#import "MEMERealTimeData.h"

FOUNDATION_EXPORT double MEMEVersionNumber;
FOUNDATION_EXPORT const unsigned char MEMEVersionString[];


// Communication Mode
typedef enum {
    MEME_COM_UNKNOWN  = 0,    // No Connection
    MEME_COM_STANDARD = 1,      // Standard Mode
    MEME_COM_REALTIME = 2       // RealTime Mode
} MEMEDataMode;

// Error Code
typedef enum {
    MEME_OK                 = 0,
    MEME_ERROR              = 1, // Misc Error
    MEME_ERROR_SDK_AUTH     = 2, // SDK Auth Error
    MEME_ERROR_APP_AUTH     = 3, // App Auth Error
    MEME_ERROR_CONNECTION   = 4, // No Connection
} MEMEStatus;


@protocol MEMELibDelegate <NSObject>

@optional

- (void) memePeripheralFound: (CBPeripheral *) peripheral;

- (void) memePeripheralConnected: (CBPeripheral *)peripheral;
- (void) memePeripheralDisconnected: (CBPeripheral *)peripheral;

- (void) memeDataModeChanged:(MEMEDataMode) mode;

- (void) memeStandardModeDataReceived: (MEMEStandardData *) data;
- (void) memeRealTimeModeDataReceived: (MEMERealTimeData *) data;

- (void) memeAppAuthorized: (MEMEStatus) status;

@end


@interface MEMELib : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (weak, nonatomic)   id<MEMELibDelegate> delegate;

@property (readonly) BOOL            isConnected;
@property (readonly) MEMEDataMode    dataMode;

+ (MEMELib *)sharedInstance;
+ (void) setAppClientId: (NSString *) _clientId clientSecret: (NSString *) _clientSecret;

#pragma mark CONNECTION

- (MEMEStatus) startScanningPeripherals;

- (MEMEStatus) connectPeripheral:(CBPeripheral *)peripheral;
- (MEMEStatus) disconnectPeripheral;

#pragma mark DEVICE

- (MEMEStatus) changeDataMode: (MEMEDataMode) mode;

#pragma mark INFO

- (NSString *) getSDKVersion;

@end
