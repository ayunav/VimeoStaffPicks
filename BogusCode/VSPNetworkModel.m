//
//  VSPNetworkModel.m
//  BogusCode
//
//  Created by Ayuna NYC on 5/31/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import "VSPNetworkModel.h"
#import "VSPAPIManager.h"
#import "VSPVideo.h"

@implementation VSPNetworkModel


+ (VSPNetworkModel *)sharedNetworkModel
{
    static VSPNetworkModel *sharedNetworkModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkModel = [[VSPNetworkModel alloc] init];
    });
    return sharedNetworkModel;
}


- (void)fetchVideosWithOffset:(NSUInteger)offset andReturn:(void (^)(NSMutableArray<VSPVideo *> *videos))completion
{
    NSMutableArray *vimeoStaffPicksVideos = [[NSMutableArray alloc] init];
    
    VSPAPIManager *apiManager = [VSPAPIManager sharedAPIManager];
    
    [apiManager getVimeoStaffPicksVideosWithOffset:offset andReturnJSON:^(id json, NSError *error)
    {
        NSArray *results = json[@"data"];
        
        for (NSDictionary *dictionary in results)
        {
            VSPVideo *video = [[VSPVideo alloc] init];
            video.name = dictionary[@"name"];
            video.videoDescription = dictionary[@"description"];
            video.imageURLlink = [[[[dictionary valueForKey:@"pictures"] valueForKey:@"sizes"] objectAtIndex:0] valueForKey:@"link"];
            
            [vimeoStaffPicksVideos addObject:video];
        }
        completion(vimeoStaffPicksVideos);
    }];
}


@end
