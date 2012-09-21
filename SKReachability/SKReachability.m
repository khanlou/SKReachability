//
//  SKReachability.h
//
//  Created by Soroush Khanlou on 7/6/11.
//  Copyright 2011 Planetary. All rights reserved.
//

#import "SKReachability.h"
#import "Reachability.h"


NSString *const kSKReachabilityChangedNotification  = @"SKReachChanged";

@interface SKReachability () {
	Reachability* hostReach;
	Reachability* internetReach;
	Reachability* wifiReach;

	NetworkStatus status;
}

- (void) reachabilityStatusChanged:(NSNotification*)note;

@end

@implementation SKReachability

@synthesize host;
@synthesize radioPoweredOn, connectedViaWifi, connectedToHost, connectedToInternet;

+ (SKReachability*) sharedReachability {
	static dispatch_once_t pred = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&pred, ^{
		_sharedObject = [[self alloc] init]; // or some other init method
	});
	return _sharedObject;
}

- (id) init {
	self = [super init];
	if (self) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityStatusChanged:) name:kReachabilityChangedNotification object:nil];
		hostReach = [Reachability reachabilityWithHostName:@"www.google.com"];
		[hostReach startNotifier];
		
		internetReach = [Reachability reachabilityForInternetConnection];
		[internetReach startNotifier];
		
		wifiReach = [Reachability reachabilityForLocalWiFi];
		[wifiReach startNotifier];
	}
	return self;
}

- (void) setHost:(NSString *)newHost {
	host = newHost;
	
	hostReach = [Reachability reachabilityWithHostName:host];
	[hostReach startNotifier];
}

- (void) reachabilityStatusChanged:(NSNotification*)note {
	BOOL shouldPostNotification = NO;
	if ((connectedToHost != ([hostReach currentReachabilityStatus] != NotReachable)) ||
	    radioPoweredOn != (![internetReach connectionRequired]) ||
	    connectedToInternet != ([internetReach currentReachabilityStatus] != NotReachable) ||
	    connectedViaWifi != ([wifiReach currentReachabilityStatus] == ReachableViaWiFi)) {
		shouldPostNotification = YES;
	}
	connectedToHost = ([hostReach currentReachabilityStatus] != NotReachable);
	radioPoweredOn = ![internetReach connectionRequired];
	connectedToInternet = ([internetReach currentReachabilityStatus] != NotReachable);
	connectedViaWifi = ([wifiReach currentReachabilityStatus] == ReachableViaWiFi);
		
	if (shouldPostNotification) {
		[[NSNotificationCenter defaultCenter] postNotificationName:kSKReachabilityChangedNotification object:self];
	}
}

@end






