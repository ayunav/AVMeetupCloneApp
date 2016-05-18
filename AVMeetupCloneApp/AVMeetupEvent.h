//
//  AVMeetupEvent.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVMeetupEvent : NSObject 

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSURL *groupPhotoURL;

@end
