//
//  FLConnection.m
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2014/07/17.
//  Copyright (c) 2014年 norimingconception.net. All rights reserved.
//

#import "FLConnection.h"

@implementation FLConnection

-(BOOL)connectionWithUrl:(NSString*)urlString withData:(NSString*)data {
    
 
    NSLog(@"connectionwithurl withdata");
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableData * body = [NSMutableData data];
    [body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    NSHTTPURLResponse * response = nil;
    NSError * error = nil;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:&error];
    NSString * error_str = [error localizedDescription];
    
    
    if(0<[error_str length]){
        
        return NO;
        //アラート表示メソッドをデリゲートメソッドとして呼び出す。
        NSLog(@"connection failed");
       
        
    } else {
        
        NSLog(@"connection succeeded %@",error_str);
    
        
        //成功判定が出た段階でdelegateメソッドを呼び出す
        //レスポンスまで時間がかかっても非同期的に処理できるパターン
        return YES;
        [self.delegate startParse];
        
        //セレクタがあるかどうか確認する場合
       // [self test];
        
    }


}


-(void)connectionAndParseWithUrl:(NSString*)urlString withData:(NSString*)data
{
    
    if([self connectionWithUrl:urlString withData:data]){
        //通信成功時にパースを開始させる
        NSLog(@"insideconnectionandparse");
        [self.delegate startParse];
       // [self test];
        
    }else{
        //通信失敗時にアラートを表示させる
        [self.delegate showAlert];
    }
    
}
    



-(BOOL)connectionWithUrl:(NSString*)url withNSData:(NSData*)body{
    
    NSLog(@"connectionwithurl withdata");
    
    //data型が必要なため、通信クラスを使用するのではなく、独自メソッドを使用
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    
    NSHTTPURLResponse * response = nil;
    NSError * error = nil;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:&error];
    NSString *error_str = [error localizedDescription];
    
    
    
    if (0<[error_str length]) {
        return NO;
         NSLog(@"connection failed");
        
    }else{
        
        return YES;
         NSLog(@"connection succeeded");
        
    }
    
}

//デリゲートメソッドのテスト
-(void)test
{
    
    NSLog(@"testwithurl");
    if([self.delegate respondsToSelector:@selector(startParse)]) {
        NSLog(@"insideif");
        [self.delegate startParse];
        
     }
}





@end
