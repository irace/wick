//
//  WIKAPIClient.h
//  Wick
//
//  Created by Bryan Irace on 4/6/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

@interface WIKAPIClient : NSObject

@property (nonatomic) dispatch_queue_t completionQueue;

- (NSURLSessionDataTask *)search:(NSString *)query callback:(void (^)(id responseObject, NSError *error))callback;

@end
