//
//  Game.h
//  PHPhotoBrowser
//
//  Created by Peni on 2015/6/13.
//  Copyright (c) 2015 Peni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *gameDescription;
@property (nonatomic, strong) NSString *gameLabel;
@property (nonatomic, strong) NSString *thumbnailPath;
@property (nonatomic, readonly) NSURL *thumbnailURL;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSURLSessionDataTask *)browseGamesWithBlock:(void (^)(NSArray *games, NSError *error))block;

@end
