//
//  AVAPIManager.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVAPIManager : NSObject

+ (AVAPIManager *)sharedAPIManager;

+ (void)getOpenEventsJSON:(void(^)(id json, NSError *error))completionHandler;

@end
