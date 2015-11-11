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
@property FLChatViewController * chatView;

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

-(void)setText{
    
    FLChatlogViewController * send = [[FLChatlogViewController alloc]init];
    send.chatField.text = @"test";
    
    
}



-(void)testContentsArray{
    
    //組み合わせの違うidでログインしようとしたらエラーを出したい
    
    //テスト用アカウントの設定
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:35 forKey:@"mid"];
    [defaults setInteger:36 forKey:@"pid"];
    
    _chatView = [[FLChatViewController alloc]init];
    [_chatView postandGet];
    NSMutableArray * contentsArray = [[NSMutableArray alloc]init];
    contentsArray = [_chatView getContentsArrayFromUserDefaults];
    XCTAssertEqual(contentsArray.count, (NSUInteger)30, @"warning ");
    
    
    //arrayの最初のchatidをとる
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:0];
    NSString * chatid = [itemAtIndex objectForKey:@"chatid"];

    
    //一つ送っても配列のカウント数は増えない
    FLChatlogViewController * send = [[FLChatlogViewController alloc]init];
    send.chatField.text = @"test";
    [send sendClicked:nil];
    [_chatView postandGet];
    NSMutableArray * contentsArray2 = [[NSMutableArray alloc]init];
    contentsArray2 = [_chatView getContentsArrayFromUserDefaults];
    XCTAssertEqual(contentsArray.count, (NSUInteger)30, @"warning ");

    NSDictionary * itemAtIndex2 = (NSDictionary*)[contentsArray objectAtIndex:10];
    NSString * chatid2 = [itemAtIndex2 objectForKey:@"chatid"];
    
    
    
    
    //chatidはずれている
    
    
    //XCTAssertFalse(contentsArray.count,(NSUInteger)31, @"format");
    //XCTAssertEqual([_chatView getIdFromUserDefaults],35,@"warning");
    
}

-(void)testSendMessage{
    
}

-(void)test{
    
    
    FLChatViewController * view = [[FLChatViewController alloc]init];
    NSMutableArray * contentsArray = [[NSMutableArray alloc]init];
    [view postandGet];
    contentsArray = [view getContentsArrayFromUserDefaults];
    XCTAssertEqual(contentsArray.count, (NSUInteger)0, @"warning ");
    
    //30個以上だと致命的なエラーとなる
    
    
    
    
//    
//    
//    contentsArray = [view getContentsArrayFromUserDefaults];
//    XCTAssertEqual(contentsArray.count, (NSUInteger)0, @"warning ");
//   
//    
    
    
    
    
    
}



@end
