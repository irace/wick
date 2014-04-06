//
//  WickTests.m
//  WickTests
//
//  Created by Bryan Irace on 4/6/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WIKAPIClient.h"

@interface WickTests : XCTestCase

@end

@implementation WickTests

- (void)testExample {
    dispatch_queue_t callbackQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    WIKAPIClient *client = [[WIKAPIClient alloc] init];
    client.completionQueue = callbackQueue;
    
    [client search:@"Tumblr" callback:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

@end
