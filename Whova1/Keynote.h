//
//  Keynote.h
//  ITherm
//
//  Created by Anveshak on 11/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Keynote : NSObject

@property (nonatomic,strong) NSString *speakerName;
@property (nonatomic,strong) NSString *keynoteTitle;
@property (nonatomic,strong) NSString *speakerDesc;
@property (nonatomic,strong) NSString *keyimage;
@property (nonatomic,strong) NSString *university,*sessnidStr;

@property(nonatomic,retain) UIImage *kimg;
@end
