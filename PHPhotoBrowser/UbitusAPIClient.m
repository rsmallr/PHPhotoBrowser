//
//  UbitusAPIClient.m
//  PHPhotoBrowser
//
//  Created by Peni on 2015/6/13.
//  Copyright (c) 2015 Peni. All rights reserved.
//

#import "UbitusAPIClient.h"

@implementation UbitusAPIClient

static NSString * const UbitusAPIBaseURLString = @"https://tw.ugamenow.com";

+ (instancetype)sharedClient
{
    static UbitusAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UbitusAPIClient alloc] initWithBaseURL:[NSURL URLWithString:UbitusAPIBaseURLString]];
    });
    
    return _sharedClient;
}

@end
