//
//  ExchangeContactViewController.h
//  ITherm
//
//  Created by Anveshak on 2/15/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeContactViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *phoneNo;
@property (strong, nonatomic) IBOutlet UITextField *mobileNo;
@property (strong, nonatomic) IBOutlet UITextField *emailid;
@property (strong, nonatomic) IBOutlet UITextField *faxNo;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *skypeId;
@property (strong, nonatomic) IBOutlet UITextField *weChatId;

- (IBAction)saveBtnClicked:(id)sender;

@end
