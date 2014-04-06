//
//  WIKAPIClient.m
//  Wick
//
//  Created by Bryan Irace on 4/6/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "WIKAPIClient.h"
#import "WIKXMLDocumentResponseSerializer.h"

static NSString * const APIBaseURL = @"http://en.wikipedia.org/w/";

@interface WIKAPIClient()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation WIKAPIClient

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration {
    if (self = [super init]) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURL]
                                                   sessionConfiguration:sessionConfiguration];
        _sessionManager.responseSerializer = [WIKXMLDocumentResponseSerializer new];
    }
    
    return self;
}

- (id)init {
    return [self initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (void)setCompletionQueue:(dispatch_queue_t)completionQueue {
    self.sessionManager.completionQueue = completionQueue;
}

- (dispatch_queue_t)completionQueue {
    return self.sessionManager.completionQueue;
}

- (NSURLSessionDataTask *)search:(NSString *)query callback:(void (^)(id responseObject, NSError *error))callback {
    NSDictionary *params = @{
//        @"srprop": @"",
//        @"srlimit": @10,
//        @"srinfo": @"suggestion",
//        @"srsearch": query,
//        @"limit": @10,
//        @"action": @"query",
//        @"format": @"json"
                             @"action":@"opensearch",
                             @"format":@"xml",
                             @"limit":@10,
                             @"search":query
    };
    
    return [self GET:@"api.php" parameters:params callback:callback];
}

#pragma mark - Private

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters
                     callback:(void (^)(id responseObject, NSError *error))callback {
    NSParameterAssert(callback);
    
    return [self.sessionManager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(nil, error);
    }];
}

@end
