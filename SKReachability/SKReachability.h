//
//  FSReach.h
//  Fireside
//
//  Created by Soroush Khanlou on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

extern NSString *const kSKReachabilityChangedNotification;

@interface SKReachability : NSObject

@property (nonatomic, strong) NSString *host;

@property (nonatomic, assign) BOOL radioPoweredOn;
@property (nonatomic, assign) BOOL connectedToInternet;
@property (nonatomic, assign) BOOL connectedViaWifi;
@property (nonatomic, assign) BOOL connectedToHost;

+ (SKReachability*) sharedReachability;

@end
