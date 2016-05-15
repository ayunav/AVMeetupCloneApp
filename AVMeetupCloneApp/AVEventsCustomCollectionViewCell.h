//
//  AVEventsCustomCollectionViewCell.h
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVEventsCustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *meetupImageView;

@property (weak, nonatomic) IBOutlet UILabel *meetupGroupNameTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *meetupNumberOfMembersTextLabel;
@end
