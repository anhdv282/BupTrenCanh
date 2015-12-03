//
//  VideosViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "VideosViewController.h"
#import "Util.h"
@interface VideosViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;


@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] navigationBar].barTintColor = [UIColor colorWithRed: 41.0/255.0 green:181.0/255.0 blue:46.0/255.0 alpha:1.0];
    [[self navigationController] navigationBar].tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    dataArray = [[NSArray alloc] init];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
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
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
        if(jsonObject !=nil){
            // NSString *errorCode=[NSMutableString stringWithFormat:@"%@",[jsonObject objectForKey:@"response"]];
            if(![[jsonObject objectForKey:@"items"] isEqual:@""]){
                NSMutableArray *array=[jsonObject objectForKey:@"items"];
                dataArray = array;
                [self.myTable reloadData];
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
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT_PORTRAIT/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideosTableViewCell *cell = [self.myTable dequeueReusableCellWithIdentifier:@"VideosTableViewCell"];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"VideosTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    NSDictionary *snippet = [dataArray[indexPath.row] objectForKey:@"snippet"];
    NSString *description = [snippet objectForKey:@"description"];
    NSDictionary *resourceId = [snippet objectForKey:@"resourceId"];
    NSString *videoId = [resourceId objectForKey:@"videoId"];
    [cell setCell:description withID:videoId];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
