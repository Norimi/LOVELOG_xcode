//
//  FLPlanDataManager.h
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2014/07/11.
//  Copyright (c) 2014年 norimingconception.net. All rights reserved.
//

#import <Foundation/Foundation.h>
//ヘッダファイルのインポートのスコープを狭めるため、@classを使用する
//#import "FLPlan.h"

@class FLPlan;

@interface FLPlanDataManager : NSObject{
    
    //内部からの直接アクセスはmutable
    NSMutableArray * plans;
    
}

//外部から読み込むときはイミュータブルでreadonly
@property (nonatomic,readonly)NSArray * plans;

/**
 * シングルトン実装
 *
 */
+(FLPlanDataManager *)sharedManager;

-(NSArray*)getNewPlans:(int)myId;
-(BOOL)addNewPlan:(FLPlan*)newPlan;
-(BOOL)deletePlan:(int)planId;
-(void)addNewUrl:(NSString*)url withIndex:(int)planIndex;
-(void)addNewTodo:(NSString*)todo withIndex:(int)planIndex;
-(void)deleteUrl:(int)planIndex withIndex:(int)urlIndex;
-(void)deleteTodo:(int)planIndex withIndex:(int)todoIndex;
-(void)changeTitle:(int)planIndex newTitle:(NSString*)title;
-(void)changeLocation:(int)planIndex newLocation:(NSString*)location;
-(void)changeDate:(int)planIndex newDate:(NSString*)date;
-(void)changeBudget:(int)planIndex newBudget:(NSString*)budget;


/**
 * add,delete,changeしたときの通信メソッド
 *
 */


@end
