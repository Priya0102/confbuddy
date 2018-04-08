
#import <UIKit/UIKit.h>
#import "Committee.h"
#import "CommitteeCollectionViewCell.h"
#import "HCollectionReusableView.h"

@interface CommitteeViewController : UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
-(void)segValueChanged:(UISegmentedControl *)paramSender;
@property (nonatomic,strong) NSArray *conference;
@property (nonatomic,strong) NSArray *component;
@property (nonatomic,strong) NSArray *system;
@property (nonatomic,strong) NSArray *mechanics;
@property (nonatomic,strong) NSArray *fundamental;
@property (nonatomic,strong) NSArray *administrative;
@property (nonatomic,strong) NSArray *communication;
@property (nonatomic,strong) NSArray *award;
@property(nonatomic,strong) NSArray *technical;
@property(nonatomic,strong) NSArray *women;


@property (nonatomic,strong) NSArray *headertext;
@property int flag;

@property (nonatomic,strong) NSArray *exCom;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segC;


@end
