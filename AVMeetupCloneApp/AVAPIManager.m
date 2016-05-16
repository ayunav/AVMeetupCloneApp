//
//  AVAPIManager.m
//  AVMeetupCloneApp
//
//  Created by Ayuna NYC on 5/14/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AVAPIManager.h"

#define API_DATA_URL @"https://api.meetup.com/2/open_events?&sign=true&photo-host=public&zip=11222&fields=group_photo&page=20&offset=0&key=4131436d16334b6c5f3c2b4630685a29"


@implementation AVAPIManager


+ (AVAPIManager *)sharedAPIManager {
   
    static AVAPIManager *sharedAPIManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIManager = [[AVAPIManager alloc] init];
    });
    return sharedAPIManager;
    
}


+ (void)getOpenEventsJSON:(void(^)(id json, NSError *error))completionHandler {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:API_DATA_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             completionHandler(responseObject, nil);
             NSLog(@"response object in AVAPIManager is %@", responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             completionHandler(nil, error);
             NSLog(@"%@", error);
             /*
             // later add to view
             Unable to Load Groups 
             A problem with the network prevented 
              loading the available groups.
              Please, check your network settings.
             */
         }];
    
}


@end
