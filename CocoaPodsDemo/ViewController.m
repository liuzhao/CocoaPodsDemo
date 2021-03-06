//
//  ViewController.m
//  CocoaPodsDemo
//
//  Created by Liu Zhao on 15/9/29.
//  Copyright © 2015年 Liu Zhao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ZPService.h"
#import <MQTTKit.h>
#import <FMDB.h>

@interface ViewController () {
    FMDatabase *_db;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self requestService];
    
//    [self MQTTService];
    
    [self fmdbTest];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn setFrame:CGRectMake(100, 100, 50, 50)];
    [btn addTarget:self action:@selector(updateBase) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestService
{
    ZPService *service = [ZPService new];
    NSMutableURLRequest *request = [service getNewsListChannelId:@"5572a109b3cdc86cf39001db" channelName:@"国内最新" page:1];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"发送的URL：%@",operation.response.URL);
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@，错误的URL：%@",error, operation.response.URL);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)MQTTService
{
    NSString *clientID = @"MQTT";
    MQTTClient *client = [[MQTTClient alloc] initWithClientId:clientID];
    
    // connect to the MQTT server
    [client connectToHost:@"iot.eclipse.org"
        completionHandler:^(NSUInteger code) {
            if (code == ConnectionAccepted) {
                // when the client is connected, send a MQTT message
                [client publishString:@"Hello, MQTT"
                              toTopic:@"/MQTTKit/example"
                              withQos:AtMostOnce
                               retain:NO
                    completionHandler:^(int mid) {
                        NSLog(@"message has been delivered");
                    }];
            }
        }];
}

- (void)fmdbTest
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    NSLog(@"dbPath:%@",dbPath);
    
    /* 创建数据库 */
    _db = [FMDatabase databaseWithPath:dbPath];
    
    if (![_db open]) {
        // error
        return;
    }
    // some operation
    // ...
    
    /* 创建Table */
//    BOOL isSuccess = [db executeUpdate:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Phone text, Address text, Photo blob)"];
//    if (isSuccess) {
//        UIImage *image = [UIImage imageNamed:@"1024x1024ss-80.png"];
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//        [db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, Photo) VALUES (?,?,?,?,?,?)",@"Jone", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"091234567", @"Taiwan, R.O.C", data];
//    }
    
//    UIImage *image = [UIImage imageNamed:@"1024x1024ss-80.png"];
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    BOOL isUpdate = [db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, Photo) VALUES (?,?,?,?,?,?)",@"Jone", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"091234567", @"Taiwan, R.O.C", data];
//    NSLog(@"isUpdate:%d",isUpdate);
//    
    
    
    
//    [_db close];
}

- (void)updateBase
{
//    [_db executeUpdate:@"UPDATE PersonList SET Age = ? WHERE Name = ?",[NSNumber numberWithInt:30],@"Jone"];
    
//    FMResultSet *rs = [_db executeQuery:@"SELECT Name, Age, FROM PersonList"];
//    
//    while ([rs next]) {
//        NSString *name = [rs stringForColumn:@"Name"];
//        int age = [rs intForColumn:@"Age"];
//        NSLog(@"name:%@,age:%d",name, age);
//    }
//    
//    [rs close];

    NSString *address = [_db stringForQuery:@"SELECT Address FROM PersonList WHERE Name = ?",@"Jone"];
    int age = [_db intForQuery:@"SELECT Age FROM PersonList WHERE Name = ?",@"Jone"];
    NSLog(@"address:%@, age:%d",address, age);
    
//    [_db close];
}

@end
