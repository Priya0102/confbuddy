
#import <UIKit/UIKit.h>
#import "SponsorsCollectionViewCell.h"
#import "Sponsor.h"
#import "WebViewController.h"
#import "HeaderCollectionReusableView.h"

@interface SponsorViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (nonatomic,strong) NSArray *goldsponsors;
@property(nonatomic,strong) NSArray *silversponsers;
@property (nonatomic,strong) NSArray *exhibitors;
@property(nonatomic,strong) NSArray *partners;
@property (nonatomic,strong) NSArray *programSponsers;


@end
