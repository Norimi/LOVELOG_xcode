//
//  FLPlan.h
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2014/07/11.
//  Copyright (c) 2014年 norimingconception.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLPlan : NSObject
{
    //内部アクセス
//    NSMutableArray * contentsArray;
//    NSMutableArray * urlArray;
//    NSMutableArray * todoArray;
}

//外部公開はイミュータブルでreadonly
@property (strong, nonatomic,readonly)NSString * contentsArray;
@property (strong, nonatomic,readonly)NSString * title;
@property (strong, nonatomic, readonly)NSString * location;
@property (strong, nonatomic, readonly)NSString * date;
@property (strong, nonatomic,readonly)NSString * budget;
@property (strong, nonatomic,readonly)NSArray * urlArray;
@property (strong, nonatomic, readonly)NSArray * todoArray;

@end
