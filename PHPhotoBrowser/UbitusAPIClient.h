//
//  UbitusAPIClient.h
//  PHPhotoBrowser
//
//  Created by Peni on 2015/6/13.
//  Copyright (c) 2015 Peni. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface UbitusAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
