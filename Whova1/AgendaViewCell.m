

#import "AgendaViewCell.h"
#import "QuartzCore/QuartzCore.h"
@implementation AgendaViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
   
    _category.layer.masksToBounds=YES;
    _category.layer.cornerRadius=8.0;
    
   // [self requestAccessToEvents:nil afterDelay:0.4];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}





@end
