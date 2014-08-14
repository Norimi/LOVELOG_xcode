//
//  ChatViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MyChatCell.h"
#import "YourChatCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import<EGORefreshTableHeaderView.h>
#import "FLConnection.h"


@interface FLChatViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate,EGORefreshTableHeaderDelegate,FLConnectionDelegate>{
    
    
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    SystemSoundID soundID;
    __weak IBOutlet UITableView *chatTable;
    WBErrorNoticeView * notice;
    
}


@property SystemSoundID  soundID;
@property (weak, nonatomic) IBOutlet UITableView *chatTable;

@end
