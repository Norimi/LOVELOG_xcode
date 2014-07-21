//
//  PlanViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPlanViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    __weak IBOutlet UITableView *planTable;
    __weak IBOutlet UIScrollView *scrollView;
}

@property (weak, nonatomic) IBOutlet UITableView *planTable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//あえて公開するプロパティ(PlanmakeViewControllerからアクセス）
@property(strong, nonatomic)NSString * categoryString;
@property(strong, nonatomic)NSString * titleString;
@property(strong, nonatomic)NSString* dateString;
@property(strong, nonatomic)NSString * budgetString;







@end
