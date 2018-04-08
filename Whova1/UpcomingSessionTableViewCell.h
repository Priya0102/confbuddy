//
//  UpcomingSessionTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 3/1/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingSessionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *endtime;
    @property (strong, nonatomic) IBOutlet UILabel *startTime;
    @property (strong, nonatomic) IBOutlet UILabel *upcomingDate;
 @property (strong, nonatomic) IBOutlet UILabel *sessionid;
    @property (strong, nonatomic) IBOutlet UILabel *upcomingLocation;
    @property (strong, nonatomic) IBOutlet UILabel *upcomingSessionName;
    @property (strong, nonatomic) IBOutlet UILabel *upcomingSessionDetails;
    @property (strong, nonatomic) IBOutlet UIView *viewSession;
 
    @property (strong, nonatomic) IBOutlet UIButton *addMySchBtn;
    
    
    
@end
