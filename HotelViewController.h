//  HotelViewController.h
//  Whova1
//
//  Created by Anveshak on 14/10/16.
//  Copyright © 2016 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgHotel;
@property (weak, nonatomic) IBOutlet UIButton *btnesta;

@property(strong,nonatomic) NSString *urlhotel;
@property (weak, nonatomic) IBOutlet UIButton *callPhone;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@end
