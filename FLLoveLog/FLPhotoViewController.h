//
//  PhotoViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/17.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolBox/AudioToolbox.h>
#import "PhotoCell.h"
#import "WBErrorNoticeView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <EGORefreshTableHeaderView.h>



@interface FLPhotoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,NSXMLParserDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,SDWebImageManagerDelegate,UIGestureRecognizerDelegate,EGORefreshTableHeaderDelegate>{
    
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    __weak IBOutlet UITableView *photoTable;
    SystemSoundID soundID;
    
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *photoTable;


@end
