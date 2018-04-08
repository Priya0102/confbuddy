//
//  Paper.h
//  ITherm
//
//  Created by Anveshak on 12/14/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "Session.h"

@interface Paper : Session
@property (strong,nonatomic) NSString *paper_name;
@property (strong,nonatomic) NSString *paper_id;
@property (strong,nonatomic) NSString *added,*location;
@property (strong,nonatomic) NSMutableArray *authors;
@property (strong,nonatomic) NSString *paper_abstract;
@end
