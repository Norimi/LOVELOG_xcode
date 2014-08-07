//
//  PlanmakeViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPlanmakeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    __weak IBOutlet UITableView *planTable;
}
@property (weak, nonatomic) IBOutlet UITableView *planTable;
@end
