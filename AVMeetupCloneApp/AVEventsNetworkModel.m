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
        
        for (NSDictionary *dictionary in json) {
            
            AVMeetupGroup *group = [[AVMeetupGroup alloc] init];
            
            NSString *groupName = dictionary[@"results"][@"group"][@"name"];
            NSURL *groupPhotoURL = dictionary[@"results"][@"group"][@"group_photo"][@"photo_link"];
            NSString *groupMembersNickname = dictionary[@"results"][@"group"][@"who"];
            
            group.name = groupName;
            group.photoURL = groupPhotoURL;
            group.membersNickname = groupMembersNickname;
            
            [self.groups addObject:group];
    }
        
        completion(self.groups);
        
    }];

}

@end
