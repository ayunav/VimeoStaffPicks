//
//  VSPAPIManager.h
//  BogusCode
//
//  Created by Ayuna NYC on 5/31/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSPAPIManager : NSObject

+ (VSPAPIManager *)sharedAPIManager;

- (void)getVimeoStaffPicksVideosWithOffset:(NSUInteger)offset andReturnJSON:(void(^)(id json, NSError *error))completion;

@end
