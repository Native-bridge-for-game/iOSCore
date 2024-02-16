//
//  ObjcSide.m
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

#import <Foundation/Foundation.h>
#import "ObjcSide.h"
#import <iOSCore/iOSCore-Swift.h>

@implementation ObjcSide : NSObject
+ (instancetype)sharedInstance{
    static ObjcSide *shard = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shard = [[ObjcSide alloc] init];
    });
    return shard;
}

- (void)initializeWith:(NativeDataCallback)bridgeCallback {
    game = [[Game alloc] initWithCallback:self];
    
    self->dataCallback = bridgeCallback;
}

- (void)sendToNative:(const Byte *)data withLength:(int)length{
    NSData *nsData = [NSData dataWithBytes:data length:length];
    [game sendWithData:nsData];
}

- (void)fromSwiftWithData:(NSData *)data{
    self->dataCallback([data bytes], (int)data.length);
}
@end
