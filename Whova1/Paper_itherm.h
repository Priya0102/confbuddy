//
//  Paper_itherm.h
//  ITherm
//
//  Created by Anveshak on 1/16/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "Session_itherm.h"

@interface Paper_itherm : Session_itherm
@property (strong,nonatomic) NSString *paper_name;
@property (strong,nonatomic) NSString *paper_id;
@property (strong,nonatomic) NSString *added,*location;
@property (strong,nonatomic) NSMutableArray *authors;
@property (strong,nonatomic) NSString *paper_abstract;
@end
