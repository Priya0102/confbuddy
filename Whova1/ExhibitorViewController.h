//
//  ExhibitorViewController.h
//  ITherm
//
//  Created by Anveshak on 11/23/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitorViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    dispatch_queue_t queue;
}

@property (nonatomic,strong) NSMutableArray *namearr,*urlarr,*imgarray;
@property (nonatomic,strong) NSMutableArray *sponsorarr;
@property(nonatomic,retain) NSString *urlstr;



@property(nonatomic,retain)NSString *namestr,*unistr,*keynotestr,*abstractstr,*newurlpass,*indxp,*abstr2;
@property(nonatomic,retain)UIImage *keynoteimg;

-(void)parsingKeyNotes;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;



@end
