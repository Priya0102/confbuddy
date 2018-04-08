//
//  PosterViewController.h
//  ITherm
//
//  Created by Anveshak on 4/3/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PosterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *poster_title;
@property (weak, nonatomic) IBOutlet UILabel *poster_info;
@property (weak, nonatomic) IBOutlet UILabel *art_title;
@property (weak, nonatomic) IBOutlet UILabel *art_info;

@property(nonatomic,retain)NSString *poster_titlestr,*poster_infostr,*art_titlestr,*art_infostr,*temp_seesionid_str;
-(void)posterparsing;
@property(nonatomic,retain)NSOperationQueue *que;

@end
