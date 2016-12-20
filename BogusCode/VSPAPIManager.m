//
//  VSPAPIManager.m
//  BogusCode
//
//  Created by Ayuna NYC on 5/31/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import "VSPAPIManager.h"

@implementation VSPAPIManager

+ (VSPAPIManager *)sharedAPIManager
{
    static VSPAPIManager *sharedAPIManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIManager = [[VSPAPIManager alloc] init];
    });
    return sharedAPIManager;
}


- (void)getVimeoStaffPicksVideosWithOffset:(NSUInteger)offset andReturnJSON:(void(^)(id json, NSError *error))completion
{
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:defaultConfig];
    
    // https://developer.vimeo.com/api/playground/channels/staffpicks/videos
    
    NSString *apiRequestBaseString = @"https://api.vimeo.com/channels/staffpicks/videos";
    NSString *pageNumber = [NSString stringWithFormat:@"?page=%lu", offset];
    NSString *apiDataURL = [NSString stringWithFormat:@"%@%@", apiRequestBaseString, pageNumber];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:apiDataURL]];
    [request setValue:@"bearer b8e31bd89ba1ee093dc6ab0f863db1bd" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                                       {
                                                           NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           
                                                           completion(jsonDict, nil);
                                                       }];
    [dataTask resume];
}


@end
