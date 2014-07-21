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
        
    } else {
        
        return YES;
        
    }


}


-(BOOL)connectionWithUrl:(NSString*)url withNSData:(NSData*)body{
    
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
        
    }else{
        
        return YES;
        
    }
    
}



@end
