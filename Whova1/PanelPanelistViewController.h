//
//  PanelPanelistViewController.h
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelPanelistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLSessionDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *panelistarr;
@property (retain,nonatomic) NSMutableArray *panelist_universityarr;

@property(nonatomic,retain)NSString *session_namestr,*infostr,*sessionstr,*abstractstr,*chairnamestr,*universitystr,*panelnamestr,*tempsessionid;
-(void)panelparsing;
@property(nonatomic,retain)NSOperationQueue *que;
@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *sessionid;
@property (retain, nonatomic) IBOutlet UILabel *abstract;
@property (weak, nonatomic) IBOutlet UILabel *chairname;
@property (weak, nonatomic) IBOutlet UILabel *university;
@property (weak, nonatomic) IBOutlet UILabel *panelname;
@end
