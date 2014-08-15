//
//  FLChatTest.m
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2014/08/14.
//  Copyright (c) 2014年 norimingconception.net. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLChatViewController.h"
#import "FLChatlogViewController.h"

@interface FLChatTest : XCTestCase

@end

@implementation FLChatTest

- (void)setUp
{
    [super setUp];
    
    //別のテスト：アカウントまわり。
    //違ったidでログインすると、パートナーとアカウントが作成できずエラーになるとか
    // Put setup code here; it will be run once, before the first test case.
    //テスト内容：送信して成功するとcontentsarrayの三十個めが消える
    //送信成功、reloadすると、ひとつずれた30個が取得される
    //送った側のidが取得されるidと等しい
    //idが0のときエラーになる
    //送ったあとのchatidはもとのchatidより大きい
   
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void)testContentsArray{
    
    
    FLChatViewController * view = [[FLChatViewController alloc]init];
    NSMutableArray * contentsArray = [[NSMutableArray alloc]init];
    [view postandGet];
    contentsArray = [view getContentsArrayFromUserDefaults];
    XCTAssertEqual(contentsArray.count, (NSUInteger)0, @"warning ");
//    
    FLChatlogViewController * send = [[FLChatlogViewController alloc]init];
    send.chatField.text = @"test";
//    [send sendChat];
//    
//    [view postandGet];
//    
    
    
    
    
    
    
}

@end
