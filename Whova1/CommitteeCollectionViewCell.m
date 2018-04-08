

#import "CommitteeCollectionViewCell.h"

@implementation CommitteeCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.img.layer.masksToBounds=YES;
    self.img.layer.borderColor=[UIColor blackColor].CGColor;
    self.img.layer.borderWidth=1.1;
    //self.kimagev.layer.cornerRadius=38;
    self.img.layer.shadowColor=[UIColor redColor].CGColor;
    
}




@end
