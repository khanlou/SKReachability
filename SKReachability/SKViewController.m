//
//  SKViewController.m
//  SKReachability
//
//  Created by Soroush Khanlou on 9/21/12.
//
//

#import "SKViewController.h"
#import "SKReachability.h"

@interface SKViewController ()

@end

@implementation SKViewController

@synthesize radioLabel, internetLabel, wifiLabel, hostLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[SKReachability sharedReachability];
	[SKReachability sharedReachability].host = @"www.appladadsfae.com";
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kSKReachabilityChangedNotification object:nil];
}

- (void) reachabilityChanged:(NSNotification*)note {
	SKReachability *reachability = [SKReachability sharedReachability];
	radioLabel.text = reachability.radioPoweredOn ? @"Radio on: Yes" : @"Radio on: No";
	internetLabel.text = reachability.connectedToInternet ? @"Connected to Internet: Yes" : @"Connected to Internet: No";
	wifiLabel.text = reachability.connectedViaWifi ? @"Connected to Wifi: Yes" : @"Connected to Wifi: No";
	hostLabel.text = reachability.connectedToHost ? @"Connected to host: Yes" : @"Connected to host: No";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
