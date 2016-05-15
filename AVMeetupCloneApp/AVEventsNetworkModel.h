//
//  AVEventsNetworkModel.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AVEventsNetworkModel : NSObject

- (void)fetchEventsData:(void (^)())completion;


@end
