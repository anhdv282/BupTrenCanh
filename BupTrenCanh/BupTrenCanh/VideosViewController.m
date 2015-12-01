//
//  VideosViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;


@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataUseAFNetworking];
}

- (void) initDataUseAFNetworking {
    NSOperationQueue *networkQueue = [[NSOperationQueue alloc] init];
//    networkQueue.maxConcurrentOperationCount = 5;
    
    NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLsBW_1WPxx6K33s0_XM3nXHim4LYYu1OA&maxResults=50&key=AIzaSyA_7gzesuwhtAd91MZQkL47QDcDpMcmBXk"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // do whatever you'd like here; for example, if you want to convert
        // it to a string and log it, you might do something like:
        
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonError;
        NSArray *jsonDataArray = [[NSArray alloc]init];
        jsonDataArray = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
        
        NSLog(@"jsonDataArray: %@",jsonDataArray);
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
        if(jsonObject !=nil){
            // NSString *errorCode=[NSMutableString stringWithFormat:@"%@",[jsonObject objectForKey:@"response"]];
            
            
            if(![[jsonObject objectForKey:@"#data"] isEqual:@""]){
                
                NSMutableArray *array=[jsonObject objectForKey:@"#data"];
                // NSLog(@"array: %@",array);
                NSLog(@"array: %d",array.count);
                
                int k = 0;
                for(int z = 0; z<array.count;z++){
                    
                    NSString *strfd = [NSString stringWithFormat:@"%d",k];
                    NSDictionary *dicr = jsonObject[@"#data"][strfd];
                    k=k+1;
                    
                }
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
    }];
    [networkQueue addOperation:operation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
