//
//  AVEventsNetworkModel.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AVMeetupEvent.h"
#import "AVAPIManager.h"

@interface AVEventsNetworkModel : NSObject

- (void)fetchEvents:(void (^)(NSMutableArray<AVMeetupEvent *> *events))completion;

@end
