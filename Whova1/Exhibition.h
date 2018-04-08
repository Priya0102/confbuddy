//
//  Exhibition.h
//  ITherm
//
//  Created by Anveshak on 2/9/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Exhibition : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *imgurl;
@property(nonatomic,strong) NSString *number,*artidStr;
@property(nonatomic,strong)NSString *liked;
@end
