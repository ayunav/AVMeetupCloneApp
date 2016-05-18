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

@interface AVEventsCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<AVMeetupEvent *> *events;

@end


@implementation AVEventsCollectionViewController

static NSString * const reuseIdentifier = @"AVEventsCustomCollectionViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBarUI];

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"AVEventsCustomCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.

    [self fetchEventsData];
}


- (void)setupNavigationBarUI {
    
    self.navigationItem.title = @"Meetup Events Near You";
    
    // Meetup brand color: http://brandcolors.net/ hex value: e0393e hex to rgb: http://hex.colorrrs.com/ rgb(224,57,62)
    
    // http://stackoverflow.com/questions/599405/iphone-navigation-bar-title-text-color
    
    // my own StackOverflow answer to How can I create a UIColor from a hex string?: http://stackoverflow.com/a/33419207/5503769
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:224.0/255.0 green:57.0/255.0 blue:62.0/255.0 alpha:1.0]};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchEventsData {
    
    AVEventsNetworkModel *networkModel = [AVEventsNetworkModel sharedNetworkModel];
    
    [networkModel fetchEvents:^(NSMutableArray<AVMeetupEvent *> *events) {
        
        self.events = events;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    
}


- (void)pullToRefresh:(UIRefreshControl *)sender {
   
    [self fetchEventsData];
    [sender endRefreshing];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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

    if (event.groupPhotoURL) {
        
        [cell.meetupImageView sd_setImageWithURL:event.groupPhotoURL
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           
                                           cell.meetupImageView.image = image;
                                           
                                       }];
    }

    cell.meetupEventNameLabel.text = event.name;
    
    // meetup date & time
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AVEventDetailViewController *eventDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AVEventDetailViewController"];
    
    eventDetailVC.event = self.events[indexPath.row];
    
    [self.navigationController pushViewController:eventDetailVC animated:YES];

}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
