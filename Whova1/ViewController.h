

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSString *result;

@property(nonatomic,strong)NSArray *patternImagesArray;
@property (weak, nonatomic) IBOutlet UILabel *message;

@property(nonatomic,strong)NSArray *labelArray;
@property (weak, nonatomic) IBOutlet UIImageView *animationView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (strong,nonatomic) NSString *role_id;

@property int maximumZoomScale;
@property int minimumZoomScale;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll2;
@property (strong, nonatomic) IBOutlet UIView *contentview2;

//@property (weak, nonatomic) IBOutlet UIButton *pdfBtn;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint *widthConstraint;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint *heightConstraint;
@end

