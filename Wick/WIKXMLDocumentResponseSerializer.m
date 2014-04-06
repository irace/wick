//
//  WIKXMLDocumentResponseSerializer.m
//  Wick
//
//  Created by Bryan Irace on 4/6/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

#import "WIKXMLDocumentResponseSerializer.h"
#import <Ono/Ono.h>

@implementation WIKXMLDocumentResponseSerializer

@synthesize acceptableContentTypes;

- (id)init {
    if (self = [super init]) {
        self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml", nil];
    }
    
    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    if ([self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        NSError *onoError;
        ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&onoError];
        
        if (onoError) {
            NSLog(@"Ono error: %@", onoError);
            return nil;
        }
        
        return document;
    }
        
    return nil;
}

@end
