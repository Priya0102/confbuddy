//
//  KeynoteViewController.h
//  ITherm
//
//  Created by Anveshak on 11/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeynoteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    dispatch_queue_t queue;
}
@property (nonatomic,strong) NSMutableArray *keynote,*abstrarray,*imgarray,*invitedArray,*sessionidArr;
@property (nonatomic,strong) NSMutableArray *talk;
@property(nonatomic,retain) NSString *urlstr;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segC;


@property(nonatomic,retain)NSString *namestr,*unistr,*keynotestr,*abstractstr,*newurlpass,*indxp,*abstr2,*sessionidStr;
@property(nonatomic,retain)UIImage *keynoteimg;

@property (nonatomic,strong) NSArray *keynotearr;
-(void)parsingKeyNotes;
//-(void)parsinginviteds;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


//- (IBAction)segvaluechange:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;




@end
