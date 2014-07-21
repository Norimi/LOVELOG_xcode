//
//  FLPlanDataManager.m
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2014/07/11.
//  Copyright (c) 2014年 norimingconception.net. All rights reserved.
//

#import "FLPlanDataManager.h"
#import "FLPlan.h"


@interface FLPlanDataManager()

@property NSMutableArray * plans;
@property FLPlan * aPlan;


@end

@implementation FLPlanDataManager
@synthesize plans;


-(id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    //ここで全plansを読み込む？
    plans = [NSMutableArray array];
    return self;
}

#pragma  mark public
//**********シングルトン実装********************
static FLPlanDataManager * _sharedInstance =nil;

+(FLPlanDataManager *)sharedManager
{
    if(!_sharedInstance){
        _sharedInstance = [[FLPlanDataManager alloc]init];
    }
    return _sharedInstance;
}
//********************************************


-(NSArray *)getNewPlans:(int)myId{
    
    //todo:通信してサーバーに入っているプランをとってくる
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    //todo:このdictionary型はflplanを採用していないので書き直す
    return [defaults2 objectForKey:@"plancontents"];
}

-(BOOL)addNewPlan:(FLPlan*)newPlan{
    
    [plans addObject:newPlan];
    return YES;
    
}

-(BOOL)deletePlan:(int)planId{
    //PHP未実装のメソッド
    //idを送信して一件ずつサーバーから消去する、
    //このメソッドの後は通信してreloadする
    
    return YES;
}

-(void)addNewUrl:(NSString*)url withIndex:(int)planIndex
{
    //このarrayに取得した全コンテンツを読み込む
    //objectatindexは、tableviewを利用して取得
    _aPlan = [plans objectAtIndex:planIndex];
    //[_aPlan.urlArray addObject:url];
    
}

-(void)addNewTodo:(NSString*)todo withIndex:(int)planIndex{
    
    _aPlan = [plans objectAtIndex:planIndex];
   // [_aPlan.todoArray addObject:todo];
    
    
}

-(void)deleteUrl:(int)planIndex withIndex:(int)urlIndex{
    
    _aPlan = [plans objectAtIndex:planIndex];
   // [_aPlan.urlArray removeObjectAtIndex:urlIndex];
}


-(void)deleteTodo:(int)planIndex withIndex:(int)todoIndex{
     _aPlan = [plans objectAtIndex:planIndex];
   // [_aPlan.todoArray removeObjectAtIndex:todoIndex];
    
}

-(void)changeTitle:(int)planIndex newTitle:(NSString*)title{
    
    _aPlan = [plans objectAtIndex:planIndex];
   // _aPlan.title = title;

}

-(void)changeLocation:(int)planIndex newLocation:(NSString*)location{
    _aPlan = [plans objectAtIndex:planIndex];
   // _aPlan.location = location;
    
}
-(void)changeDate:(int)planIndex newDate:(NSString*)date{
    _aPlan = [plans objectAtIndex:planIndex];
   // _aPlan.date = date;
}
-(void)changeBudget:(int)planIndex newBudget:(NSString*)budget{
    _aPlan = [plans objectAtIndex:planIndex];
   // _aPlan.date = budget;
}

//NSUserDefaultに結果をしまう







@end
