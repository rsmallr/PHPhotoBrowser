//
//  Game.m
//  PHPhotoBrowser
//
//  Created by Peni on 2015/6/13.
//  Copyright (c) 2015 Peni. All rights reserved.
//

#import "Game.h"
#import "UbitusAPIClient.h"

static NSString * const UbitusImageBaseURLString = @"https://tw.ugamenow.com/images/ubilive/";

@implementation Game

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.gameName = (NSString *)[attributes valueForKeyPath:@"name"];
    self.gameLabel = (NSString *)[attributes valueForKeyPath:@"label"];
    self.gameDescription = (NSString *)[attributes valueForKeyPath:@"description"];
    if ([attributes valueForKeyPath:@"attributes"]) {
        self.thumbnailPath = [[attributes valueForKeyPath:@"attributes"] valueForKeyPath:@"thumbnail-cover-200x272"];
    }
    
    return self;
}

- (NSURL *)thumbnailURL
{
    if (!self.gameLabel ||
        self.gameLabel.length <= 0 ||
        !self.thumbnailPath ||
        self.thumbnailPath.length <= 0) {
        return nil;
    }
    
    return [NSURL URLWithString:[[UbitusImageBaseURLString stringByAppendingPathComponent:self.gameLabel] stringByAppendingPathComponent:self.thumbnailPath]];
}

#pragma mark -

+ (NSURLSessionDataTask *)browseGamesWithBlock:(void (^)(NSArray *games, NSError *error))block
{
    return [[UbitusAPIClient sharedClient] GET:@"gamecontent/games" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *gamesFromResponse = [JSON valueForKeyPath:@"games"];
        NSMutableArray *mutableGames = [NSMutableArray arrayWithCapacity:[gamesFromResponse count]];
        for (NSDictionary *attributes in gamesFromResponse) {
            Game *game = [[Game alloc] initWithAttributes:attributes];
            [mutableGames addObject:game];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableGames], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
