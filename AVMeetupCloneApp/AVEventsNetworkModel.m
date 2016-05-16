//
//  AVEventsNetworkModel.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import "AVEventsNetworkModel.h"

@interface AVEventsNetworkModel()

@property (nonatomic, strong) NSMutableArray *groups;

@end


@implementation AVEventsNetworkModel

- (void)fetchEvents:(void (^)(NSMutableArray<AVMeetupGroup *> *groups))completion {

    self.groups = [[NSMutableArray alloc] init];
    
    [AVAPIManager getOpenEventsJSON:^(id json, NSError *error) {
        
        NSArray *results = [json valueForKey:@"results"];
        
        for (NSDictionary *dictionary in results) {
            
            AVMeetupGroup *group = [[AVMeetupGroup alloc] init];
            
            NSString *groupName = dictionary[@"group"][@"name"];
            NSURL *groupPhotoURL = dictionary[@"group"][@"group_photo"][@"photo_link"];
            NSString *groupMembersNickname = dictionary[@"group"][@"who"];
            
            group.name = groupName;
            group.photoURL = groupPhotoURL;
            group.membersNickname = groupMembersNickname;
            
//            NSLog(@"%@, %@, %@ ", group.name, group.photoURL, group.membersNickname); 
            
            [self.groups addObject:group];
    }
        
        completion(self.groups);
        
    }];

}

@end
