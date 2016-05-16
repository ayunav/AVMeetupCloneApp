//
//  AVMeetupGroup.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVMeetupGroup : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSString *membersNickname;

@end
