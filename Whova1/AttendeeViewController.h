
#import <UIKit/UIKit.h>

#import "PaperTableViewCell.h"
#import "Paper_author.h"

@interface AttendeeViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate>

@property (nonatomic,strong) NSArray *result;
@property (nonatomic,strong) NSArray *searchresult;
//@property (nonatomic,strong) NSArray *authors;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray *paper_id;
@property (strong,nonatomic) NSMutableArray *paper_name;
@property (strong,nonatomic) NSMutableArray *all_authors;

@property (strong,nonatomic) NSArray *filteredarray;
@end
