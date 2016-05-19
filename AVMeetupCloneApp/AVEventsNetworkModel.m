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

+ (AVEventsNetworkModel *)sharedNetworkModel {
    
    static AVEventsNetworkModel *sharedNetworkModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkModel = [[AVEventsNetworkModel alloc] init];
    });
    return sharedNetworkModel;
}


- (void)fetchEvents:(void (^)(NSMutableArray<AVMeetupEvent *> *events))completion {

    self.events = [[NSMutableArray alloc] init];
    
    [AVAPIManager getOpenEventsJSON:^(id json, NSError *error) {
        
        NSArray *results = [json valueForKey:@"results"];
        
        for (NSDictionary *dictionary in results) {
            
            AVMeetupEvent *event = [[AVMeetupEvent alloc] init];
            
            // set event name and event description
            
            NSString *eventName = dictionary[@"name"];
            NSString *eventDescription = dictionary[@"description"];
            
            event.name = eventName;
            event.eventDescription = eventDescription;
            
            // set meetup group photo
            
            NSDictionary *group = dictionary[@"group"];
            NSDictionary *groupPhoto = group[@"group_photo"];
            
            if (groupPhoto) {
                NSURL *groupPhotoURL = groupPhoto[@"photo_link"];
                event.groupPhotoURL = groupPhotoURL;
            }
            
            // set meetup time and date
            
            /* UTC start time of the event, in milliseconds since the epoch - http://www.meetup.com/meetup_api/docs/2/open_events/ */
            NSString *epochTime = dictionary[@"time"];
  
            NSTimeInterval seconds = [epochTime doubleValue]/1000;
            NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE, MMMM dd 'at' hh:mm a"];
            
            NSString *eventTimeAndDate = [dateFormatter stringFromDate:epochNSDate];
            event.timeAndDate = eventTimeAndDate;
            
            
            [self.events addObject:event];
    }
        
        completion(self.events);
        
    }];

}

@end
