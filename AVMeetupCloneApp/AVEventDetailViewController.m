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
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *eventDescriptionWebView;

@end


@implementation AVEventDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", self.event.timeAndDate];
   
    self.eventNameLabel.text = self.event.name;
    
    self.meetupGroupImageView.clipsToBounds = YES;
    
    [self.meetupGroupImageView sd_setImageWithURL:self.event.groupPhotoURL
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                       self.meetupGroupImageView.image = image;
                                       
                                   }];

    //developer.apple.com/library/ios/documentation/UIKit/Reference/UIWebView_Class/index.html#//apple_ref/doc/uid/TP40006950-CH3-SW10
    // http://stackoverflow.com/a/4138610/5503769
    
    [self.eventDescriptionWebView loadHTMLString:[self.event.eventDescription description] baseURL:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
