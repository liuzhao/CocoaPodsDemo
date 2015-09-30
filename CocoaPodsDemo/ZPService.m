//
//  ZPService.m
//  Project_D
//
//  Created by Liu Zhao on 15/9/28.
//  Copyright © 2015年 Liu Zhao. All rights reserved.
//

#import "ZPService.h"

static NSString *apikey = @"0ff5ea96ea22a108b1a3932c64a4692b";
static NSString *search_news = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";

@implementation ZPService

- (NSString *)normalizedRequestParameters:(NSDictionary *)aParameters {
    NSMutableArray *parametersArray = [NSMutableArray array];
    for (NSString *key in aParameters) {
        NSString *value = [aParameters valueForKey:key];
        [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",
                                    key,
                                    value]];
    }
    return [parametersArray componentsJoinedByString:@"&"];
}

- (NSMutableURLRequest *)getNewsListChannelId:(NSString *)channelId channelName:(NSString *)channelName page:(NSInteger)page
{
    NSString *httpUrl = search_news;
    
    NSDictionary *parameters = @{@"channelId": channelId, @"channelName": channelName, @"page": [NSNumber numberWithInteger:page]};
    
    NSString *parameter = [self normalizedRequestParameters:parameters];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?%@",httpUrl, parameter];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:apikey forHTTPHeaderField:@"apikey"];
    
    return request;
}

@end
