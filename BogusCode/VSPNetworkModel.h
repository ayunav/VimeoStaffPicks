//
//  VSPNetworkModel.h
//  BogusCode
//
//  Created by Ayuna NYC on 5/31/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VSPVideo.h"

@interface VSPNetworkModel : NSObject

+ (VSPNetworkModel *)sharedNetworkModel;

- (void)fetchVideosWithOffset:(NSUInteger)offset andReturn:(void (^)(NSMutableArray<VSPVideo *> *videos))completion;

@end
