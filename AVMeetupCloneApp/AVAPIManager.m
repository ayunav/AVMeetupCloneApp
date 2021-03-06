//
//  AVAPIManager.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AVAPIManager.h"

@implementation AVAPIManager


+ (AVAPIManager *)sharedAPIManager {
   
    static AVAPIManager *sharedAPIManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIManager = [[AVAPIManager alloc] init];
    });
    return sharedAPIManager;
    
}


- (void)getOpenEventswithOffset:(NSUInteger)offset andReturnJSON:(void(^)(id json, NSError *error))completionHandler {
    
    NSString *meetupAPIURL = @"https://api.meetup.com/2/open_events?&sign=true&photo-host=public&zip=10001&fields=group_photo&page=20&offset=";
    
    NSString *apiKey = @"&key=YOUR_API_KEY"; // INSERT YOUR API KEY INSTEAD OF YOUR_API_KEY HERE 
    
    NSString *apiDataURL = [NSString stringWithFormat:@"%@%lu%@", meetupAPIURL, offset,apiKey];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:apiDataURL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             completionHandler(responseObject, nil);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             completionHandler(nil, error);
             NSLog(@"%@", error);
         
         }];
    
}


@end
