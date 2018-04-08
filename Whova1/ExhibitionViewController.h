//
//  ExhibitionViewController.h
//  ITherm
//
//  Created by Anveshak on 2/9/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
{
    dispatch_queue_t queue;
    CGFloat *alpha;
    UIImageView *heartPopup;
    CGAffineTransform *transform;
}

@property (nonatomic,strong) NSMutableArray *namearr,*numberarr,*imgarray,*artidArr,*likedArr;
@property (nonatomic,strong) NSMutableArray *exhibitionArr,*artArr,*tickArr;
@property(nonatomic,retain) NSString *urlstr;
@property(nonatomic,retain)NSString *namestr,*newurlpass,*indxp,*success;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
-(void)parsingArtExhibition;



//@property(strong,nonatomic)CGAffineTransform *transform;
//- (IBAction)likeBtnClicked:(id)sender;


@end
