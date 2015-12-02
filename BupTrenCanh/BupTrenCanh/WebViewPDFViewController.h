//
//  WebViewPDFViewController.h
//  BupTrenCanh
//
//  Created by mac on 12/2/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewPDFViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (void)showInView:(BOOL)animated aView:(UIView *)aView reason:(NSString *)reason;
@end
