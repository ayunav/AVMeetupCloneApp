//
//  AVEventDetailViewController.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import "AVEventDetailViewController.h"

@interface AVEventDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *meetupGroupImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end


@implementation AVEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    
    self.descLabel.text = self.event.eventDescription;
    
    self.meetupGroupImageView.clipsToBounds = YES;
    
    [self.meetupGroupImageView sd_setImageWithURL:self.event.groupPhotoURL
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                       self.meetupGroupImageView.image = image;
                                       
                                   }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
