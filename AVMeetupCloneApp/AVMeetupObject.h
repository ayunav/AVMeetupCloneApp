//
//  AVMeetupObject.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVMeetupObject : NSObject

@property (nonatomic, strong) NSString *meetupName;
@property (nonatomic, strong) NSString *membersNickname;

@property (nonatomic, strong) NSString *meetupImageURLString;
@property (nonatomic, strong) NSArray *meetupImagesArray; 

@end
