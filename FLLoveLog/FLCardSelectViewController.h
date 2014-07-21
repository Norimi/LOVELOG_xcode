//
//  CardSelectViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"
#import<EGORefreshTableHeaderView.h>


@interface FLCardSelectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate,EGORefreshTableHeaderDelegate>{
    
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    __weak IBOutlet UITableView *dateTable;
    
}
@property (weak, nonatomic) IBOutlet UITableView *dateTable;
@end
