//
//  PDFViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *path = [[NSBundle mainBundle] pathForResource:self.myPath ofType:@"pdf"];
//    NSString *sourcePath;
////    if(self.myPath) {
////        
////    } else {
////        if (self.index == 0) {
////            sourcePath = [[NSBundle mainBundle] pathForResource:@"NHCHVTHVQTET1"ofType:@"pdf"];
////        }
////    }
//    sourcePath = [[NSBundle mainBundle] pathForResource:@"NHCHVTHVQTET1"ofType:@"pdf"];
//    NSURL *targetURL = [NSURL fileURLWithPath:sourcePath];
//    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
//    [self.myWebView loadRequest:request];
    [self.view bringSubviewToFront:self.myWebView];
    [self loadPDF];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadPDF {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CongUocLHQVeQuyenTreEm1989" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.myWebView loadRequest:request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
