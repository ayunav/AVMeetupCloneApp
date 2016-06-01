//
//  AVEventsCollectionViewController.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import "AVEventsNetworkModel.h"
#import "AVEventsCustomCollectionViewCell.h"
#import "AVEventsCollectionViewController.h"
#import "AVEventDetailViewController.h"

#define meetupBrandRedColor [UIColor colorWithRed:224.0/255.0 green:57.0/255.0 blue:62.0/255.0 alpha:1.0]


@interface AVEventsCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<AVMeetupEvent *> *events;

@end


@implementation AVEventsCollectionViewController

static NSString * const reuseIdentifier = @"AVEventsCustomCollectionViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"AVEventsCustomCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];

    [self setupNavigationBarUI];
    [self addUIRefreshControlToCollectionView];
    
    self.events = [[NSArray alloc] init];
    [self fetchEventsDataWithOffset:0];
    
}


- (void)setupNavigationBarUI {
    
    self.navigationItem.title = @"Meetup Events";
    
    // Meetup brand color: http://brandcolors.net/ hex value: e0393e hex to rgb: http://hex.colorrrs.com/ rgb(224,57,62)

    // http://stackoverflow.com/questions/599405/iphone-navigation-bar-title-text-color
    
    // my own StackOverflow answer to How can I create a UIColor from a hex string?: http://stackoverflow.com/a/33419207/5503769
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: meetupBrandRedColor};
    [self.navigationController.navigationBar setTintColor:meetupBrandRedColor];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)fetchEventsDataWithOffset:(NSUInteger)offset {
    
    AVEventsNetworkModel *networkModel = [AVEventsNetworkModel sharedNetworkModel];
    
    [networkModel fetchEventsWithOffset:offset andReturnEvents:^(NSMutableArray<AVMeetupEvent *> *events) {
        
        
        self.events = [self.events arrayByAddingObjectsFromArray:events];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    
}

#pragma mark - Pull Down To Refresh methods

- (void)addUIRefreshControlToCollectionView {
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;

}


- (void)pullToRefresh:(UIRefreshControl *)sender {
   
    [self fetchEventsDataWithOffset:0];
    [sender endRefreshing];
    
}


#pragma mark - CollectionView Layout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat eventsCellWidth = ((screenWidth / 2) - 15); 
    CGFloat eventsCellHeight = 155;
    return CGSizeMake(eventsCellWidth, eventsCellHeight);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.events.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AVEventsCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    AVMeetupEvent *event = self.events[indexPath.row];

    // meetup event name
    cell.meetupEventNameLabel.text = event.name;

    // meetup group photo
    
    if (event.groupPhotoURL) {
        
        [cell.meetupImageView sd_setImageWithURL:event.groupPhotoURL
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           
                                           cell.meetupImageView.image = image;
                                           
                                       }];
    }

    // meetup event time & date
    
    cell.timeAndDateLabel.text = event.timeAndDate;
    
    if (indexPath.row == self.events.count) {
        [self fetchEventsDataWithOffset:self.events.count];
    }

    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AVEventDetailViewController *eventDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AVEventDetailViewController"];
    
    eventDetailVC.event = self.events[indexPath.row];
    
    [self.navigationController pushViewController:eventDetailVC animated:YES];

}


@end
