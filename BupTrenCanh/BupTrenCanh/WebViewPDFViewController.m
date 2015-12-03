//
//  WebViewPDFViewController.m
//  BupTrenCanh
//
//  Created by mac on 12/2/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "WebViewPDFViewController.h"

@interface WebViewPDFViewController () {
    NSString *name;
}

@end

@implementation WebViewPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCloseTapped:(id)sender {
    [self removeAnimate];
}

- (void) loadPDF {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.myWebView loadRequest:request];
}

- (void)showAnimate {
    self.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.view.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 1.0;
        self.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)removeAnimate {
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)showInView:(BOOL)animated aView:(UIView *)aView reason:(NSString *)reason {
    [aView addSubview:self.view];
//    self.txtReason.text = reason;
    name = reason;
    if (animated)
    {
        [self showAnimate];
    }
    [self loadPDF];
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
