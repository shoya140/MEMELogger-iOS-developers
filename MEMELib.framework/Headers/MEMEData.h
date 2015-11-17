//
//  MEMEData.h
//  
//
//  Created by JINS MEME on 2015/02/06.
//  Copyright (c) 2015年 JINS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEMEData : NSObject

- (instancetype)initWithDataPacket: (UInt8 *)data;

- (uint64_t) getUnixTime: (UInt8 *) data;
- (UInt16) getUInt16: (UInt8 *)data;
- (SInt16) getSInt16: (UInt8 *)data;

@end
