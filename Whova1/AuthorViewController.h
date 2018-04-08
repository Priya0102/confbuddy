//
//  AuthorViewController.h
//  ITherm
//
//  Created by Anveshak on 2/15/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *authorName;
@property (strong, nonatomic) IBOutlet UIImageView *authorImage;
@property (strong, nonatomic) IBOutlet UILabel *authorUniversity;
- (IBAction)exchangeBtnClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *authorAffiliation;
@property (strong, nonatomic) IBOutlet UILabel *authorDesignation;
@property (strong, nonatomic) IBOutlet UILabel *papername;
@property (strong, nonatomic) IBOutlet UILabel *paperid;
@property (strong, nonatomic) IBOutlet UILabel *starttime;
@property (strong, nonatomic) IBOutlet UILabel *endtime;
@property (strong, nonatomic) IBOutlet UILabel *authorid;

@property (strong, nonatomic) IBOutlet UILabel *authorNameExchange;

@property(nonatomic,retain)NSString *paperidstr,*starttimeStr,*endtimeStr,*papernameStr,*indxpath,*authoridStr,*biographyStr,*salutationStr,*firstnameStr,*lastnameStr,*affiliationStr,*designationStr,*universityStr,*authorNameStr,*authorNameExchangeStr;
@property (strong, nonatomic) IBOutlet UILabel *biography;


- (IBAction)seeMoreBtnClicked:(id)sender;


@property(strong,nonatomic)NSMutableArray *kimgarray;

@end
