# SKReachability

SKReachability is a singleton that gives quick access to information about the connection.

# Usage

Usage is simple. Call `	[SKReachability sharedReachability]` to initialize the singleton. Set the `host` property to test connection to a specific host. It defaults to the Google homepage.

Subscribe to notifications for reachability changes:

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kSKReachabilityChangedNotification object:nil];

and then you can access the properties `radioPoweredOn`, `connectedToInternet`, `connectedViaWifi`, and `connectedToHost` when the notification is fired. You can also access them at any point to determine the state of the network.

SKReachability relies on Apple's Reachability.