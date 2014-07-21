//
//  OldplansViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/29.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLOldplansViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    __weak IBOutlet UITableView *planTable;
    
}

//plantableviewcontrollerからアクセスするプロパティ
@property(strong, nonatomic)NSMutableArray * plantodoArray;
@property(strong, nonatomic)NSMutableArray * planurlArray;
@property(strong, nonatomic)NSMutableArray * urlidArray;
@property(strong, nonatomic)NSMutableArray * planboolArray;
@property(strong, nonatomic)NSMutableArray * passedtodoidArray;
@property(strong, nonatomic)NSString * categoryString;
@property(strong, nonatomic)NSString * titleString;
@property(strong, nonatomic)NSString * dateString;
@property(strong, nonatomic)NSString * budgetString;
@property(strong, nonatomic)NSString * oldplanid;
@property (weak, nonatomic) IBOutlet UITableView *planTable;

@end
