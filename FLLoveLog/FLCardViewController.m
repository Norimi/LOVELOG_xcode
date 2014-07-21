//
//  CardViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/31.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLCardViewController.h"
#import "CardCell.h"
#import "FLCardTextViewController.h"

@interface FLCardViewController()
@property(strong, nonatomic,readonly)NSArray * thumbnails;
@end

@implementation FLCardViewController
static const int HEIGHT_FOR_A_CARD = 469;

@synthesize thumbnails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    self.title = @"カードの選択";
    thumbnails = [NSArray arrayWithObjects:@"cardstyle1.png", @"cardstyle2.png", @"cardstyle3.png", nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [thumbnails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CardCell";
    CardCell *cell = (CardCell *)[tableView  dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"CardCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.cardImage.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return cell;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLCardTextViewController * CTVC = [[FLCardTextViewController alloc]init];
    CTVC.cardName = [thumbnails objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:CTVC animated:YES];
    CTVC = nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  HEIGHT_FOR_A_CARD;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
