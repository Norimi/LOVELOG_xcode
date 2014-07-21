//
//  CardCell.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/31.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell{
    
    __weak IBOutlet UIImageView *cardImage;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;

@end
