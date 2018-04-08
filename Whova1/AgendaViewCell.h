

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface AgendaViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *tolabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;


@property (weak, nonatomic) IBOutlet UIImageView *duration;
@property (weak, nonatomic) IBOutlet UIImageView *location;
@property (weak, nonatomic) IBOutlet UILabel *date
;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *time_flag;


@property (weak, nonatomic) IBOutlet UILabel *line_lbl;

@property (weak, nonatomic) IBOutlet UILabel *line_down;

@end
