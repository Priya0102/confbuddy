
#import <UIKit/UIKit.h>

#import <UserNotifications/UserNotifications.h>
#import "ViewController.h"
@import Firebase;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate,FIRMessagingDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *navC;



@property (strong,nonatomic) NSString *deviceToken;
@property (strong,nonatomic) NSString *payload;
@property (strong,nonatomic) NSString *certificate,*badgeValue;

@end

