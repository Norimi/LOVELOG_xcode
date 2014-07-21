//
//  FromchatPlanViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/06/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"


@interface FLFromchatPlanViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>{
    
    
    __weak IBOutlet UITableView *fromchatTable;
    WBErrorNoticeView * notice;
    
}

//fromchatviewcontrollerからplanidを受け取る
@property(strong, nonatomic)NSString * planid;
@property (weak, nonatomic) IBOutlet UITableView *fromchatTable;
@end
