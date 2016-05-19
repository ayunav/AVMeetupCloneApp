//
//  AVEventsCustomCollectionViewCell.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import "AVEventsCustomCollectionViewCell.h"

@implementation AVEventsCustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.meetupImageView.clipsToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.meetupImageView.bounds;
    
    gradientLayer.startPoint = CGPointMake(1.0, 1.0); // dark from bottom
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor blackColor] CGColor],
                            (id)[[UIColor clearColor] CGColor], nil];
    
    [self.meetupImageView.layer insertSublayer:gradientLayer atIndex:0];
    
}

@end
