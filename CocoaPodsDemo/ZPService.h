//
//  ZPService.h
//  Project_D
//
//  Created by Liu Zhao on 15/9/28.
//  Copyright © 2015年 Liu Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPService : NSObject

- (NSMutableURLRequest *)getNewsListChannelId:(NSString *)channelId channelName:(NSString *)channelName page:(NSInteger)page;

@end
