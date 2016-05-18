//
//  AVEventsNetworkModel.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import "AVEventsNetworkModel.h"

@interface AVEventsNetworkModel()

@property (nonatomic, strong) NSMutableArray *events;

@end


@implementation AVEventsNetworkModel

- (void)fetchEvents:(void (^)(NSMutableArray<AVMeetupEvent *> *events))completion {

    self.events = [[NSMutableArray alloc] init];
    
    [AVAPIManager getOpenEventsJSON:^(id json, NSError *error) {
        
        NSArray *results = [json valueForKey:@"results"];
        
        for (NSDictionary *dictionary in results) {
            
            AVMeetupEvent *event = [[AVMeetupEvent alloc] init];
            
            NSString *eventName = dictionary[@"name"];
            NSString *eventDescription = dictionary[@"description"];
            
            NSDictionary *group = dictionary[@"group"];
            NSDictionary *groupPhoto = group[@"group_photo"];
            
            if (groupPhoto) {
                NSURL *groupPhotoURL = groupPhoto[@"photo_link"];
                event.groupPhotoURL = groupPhotoURL;
            }
            
            event.name = eventName;
            event.eventDescription = eventDescription;

            [self.events addObject:event];
    }
        
        completion(self.events);
        
    }];

}

@end
