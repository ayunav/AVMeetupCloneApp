//
//  AVEventDetailViewController.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "AVMeetupEvent.h"

@interface AVEventDetailViewController : UIViewController

@property (nonatomic, strong) AVMeetupEvent *event;

@end
