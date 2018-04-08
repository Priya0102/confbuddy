

#import "AppDelegate.h"
#import "ViewController.h"
#import "AfterLoginMainViewController.h"
#import "Reachability.h"
#import "Firebase.h"
#import <unistd.h>
#import "Constant.h"
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif
@import Firebase;
@import FirebaseMessaging;
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@end
@implementation AppDelegate
NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    sleep(3);
    
    application.applicationIconBadgeNumber = 0;
    
//    UINavigationController *navC=[[UINavigationController alloc]init];
//    [self.window makeKeyAndVisible];
//    AfterLoginMainViewController *aftC=[[AfterLoginMainViewController alloc]init];
//    [navC setViewControllers:[NSArray arrayWithObject:aftC]];
//    [self.window setRootViewController:navC];
    
    
    NSUInteger nextBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count] + 1;
    NSLog(@"%lu",(unsigned long)nextBadgeNumber);
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Explain the situation to the user" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        [alert show];
//        [alert release];
        
    }
    else {
        //other actions.
    

    
    NSInteger badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];
//    NSDateFormatter *dt1=[[NSDateFormatter alloc]init];
//    [dt1 setDateFormat:@"dd MMMM yyyy hh:mm:ss a"];
//    NSDate *da1=[dt1 dateFromString:@"2 February 2017 10:30:04 pm"];
//    NSLog(@"da is %@",da1);
    
 
   // [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:150.0/255.0 green:101.0/255.0 blue:51.0/255.0 alpha:1.0]];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0]];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
   
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]]; // for unselected items that are gray

        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor colorWithRed:66.0/255.0 green:150.0/255.0 blue:183.0/255.0 alpha:1.0]];
        
    
    UIStoryboard *storyboard = [self grabStoryboard];
    
    // display storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
  
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
    if(savedValue!=NULL)
    {
        int screenHeight = [UIScreen mainScreen].bounds.size.height;
        

        switch (screenHeight) {
                // iPhone 4s
            case 480:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;


                break;
            }
                //iPhone 5 & iPhone SE
            case 548:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            } // iPhone 5s
            case 568:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                // iPhone 6 & 6s & iPhone 7
            case 647:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                // iPhone 6 Plus & 6s Plus & iPhone 7 Plus
            case 716:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 667:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 736:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 1366:
            {
                storyboard = [UIStoryboard storyboardWithName:@"ipad2" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"ipad2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                
            default:
            {
                storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
                AfterLoginMainViewController *loginController=[[UIStoryboard storyboardWithName:@"ipad" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
        }
    }
        [FIRApp configure];
        [FIRMessaging messaging].delegate=self;
    
//}
//    
//    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
//    {
//    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//    
//    [application registerForRemoteNotifications];
//    }
//   
//    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    
//    if (notification) {
//        
//     
//        [application registerForRemoteNotifications];
//        
//        
//        
//       // [self showAlarm:notification.alertBody];
//        
//        application.applicationIconBadgeNumber = 0;
//    }
//    
//    [self.window makeKeyAndVisible];
//
        
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            // iOS 7.1 or earlier. Disable the deprecation warnings.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIRemoteNotificationType allNotificationTypes =
            (UIRemoteNotificationTypeSound |
             UIRemoteNotificationTypeAlert |
             UIRemoteNotificationTypeBadge);
            [application registerForRemoteNotificationTypes:allNotificationTypes];
#pragma clang diagnostic pop
        } else {
            // iOS 8 or later
            // [START register_for_notifications]
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
                UIUserNotificationType allNotificationTypes =
                (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
                UIUserNotificationSettings *settings =
                [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            } else {
                // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
                // For iOS 10 display notification (sent via APNS)
                [UNUserNotificationCenter currentNotificationCenter].delegate = self;
                UNAuthorizationOptions authOptions =
                UNAuthorizationOptionAlert
                | UNAuthorizationOptionSound
                | UNAuthorizationOptionBadge;
                [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
                }];
#endif
            }
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            // [END register_for_notifications]
        }

        return YES;
    }
    return 0;
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    UIApplicationState state = [application applicationState];
//    if (state == UIApplicationStateActive)
//    {
//        completionHandler(UIBackgroundFetchResultNewData);
//    }
//}

- (void)renumberBadgesOfPendingNotifications
{
    // clear the badge on the icon
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // first get a copy of all pending notifications (unfortunately you cannot 'modify' a pending notification)
    NSArray *pendingNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    // if there are any pending notifications -> adjust their badge number
    if (pendingNotifications.count != 0)
    {
        // clear all pending notifications
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        // the for loop will 'restore' the pending notifications, but with corrected badge numbers
        // note : a more advanced method could 'sort' the notifications first !!!
        NSUInteger badgeNbr = 1;
        
        for (UILocalNotification *notification in pendingNotifications)
        {
            // modify the badgeNumber
            notification.applicationIconBadgeNumber = badgeNbr++;
            
            // schedule 'again'
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    application.applicationIconBadgeNumber = 0;
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
        
        
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
}


- (UIStoryboard *)grabStoryboard {
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"screenheight==== %d",screenHeight);
    UIStoryboard *storyboard;
    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            //iPhone 5 & iPhone SE
        case 548:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
          // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 6 & 6s & iPhone 7
        case 647:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 6 Plus & 6s Plus & iPhone 7 Plus
        case 716:
            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
            break;
            
        case 667:
            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
            break;
        case 736:
            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
            break;
            
        case 1366:
            storyboard = [UIStoryboard storyboardWithName:@"ipad2" bundle:nil];
            break;

            
        default:
            // it's an iPad
            storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
            break;
    }
    
    return storyboard;
}
/*

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types!=0) {
        [application registerForRemoteNotifications];

    }

}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.deviceToken=token;
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSString *myst=[NSString stringWithFormat:@"token=%@",token];
    
NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/dev.php"];
//      NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/dev.php"];////server

    //NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/admin_ith/dev.php"];//uploaded version server api

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        }
    }];
    [dataTask resume];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSString *token=@"2d6ac025e91d54b1214a20b8d34d4167f5a20b4f3bbdd4fd00342d8a87b257a";
    self.deviceToken=token;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSString *myst=[NSString stringWithFormat:@"token=%@",token];
    
  // NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/iOSAPI/changedapis/dev.php"];
     NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/dev.php"];
//   NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/dev.php"];//server

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            
        }
        
    }];
    
  // [dataTask resume];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    for(id key in userInfo)
    {
        NSLog(@"key:%@,value:%@",key,[userInfo objectForKey:key]);
    }
//    NSLog(@"Received notification: %@",userInfo);
//    [self clearNotifications];
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    int badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

-(void)clearBadgeCount{
//    
//    self.badgeCount=0;
//    [UIApplication sharedApplication].applicationIconBadgeNumber=self.badgeCount;
}
*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}
#endif
// [END ios_10_message_handling]

// [START refresh_token]
- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"****FCM registration token: %@", fcmToken);
    // TODO: If necessary send token to application server.
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSString *myst=[NSString stringWithFormat:@"token=%@",fcmToken];
    NSLog(@"DEVICE TOKEN.....:%@",myst);
    
     NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:dev]];
    
     //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/dev.php"];
    
    
    //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/dev.php"];////server
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"%@",text);
        }
    }];
    [dataTask resume];
    
}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    
    // With swizzling disabled you must set the APNs device token here.
    // [Messaging messaging].APNSToken = deviceToken;
}



@end
