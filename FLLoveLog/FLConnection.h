//
//  FLConnection.h
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2014/07/17.
//  Copyright (c) 2014年 norimingconception.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLConnectionDelegate <NSObject>
-(void)startParse;
-(void)showAlert;
@end

@interface FLConnection : NSObject
@property (nonatomic,assign)id<FLConnectionDelegate>delegate;

-(void)test;

-(void)connectionAndParseWithUrl:(NSString *)urlString withData:(NSString*)data;
-(BOOL)connectionWithUrl:(NSString*)urlString withData:(NSString*)data;
-(BOOL)connectionWithUrl:(NSString*)url withNSData:(NSData*)body;

@end
