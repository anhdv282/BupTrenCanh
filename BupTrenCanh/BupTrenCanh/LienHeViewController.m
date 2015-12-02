//
//  LienHeViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "LienHeViewController.h"
#import "Util.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface LienHeViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation LienHeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] navigationBar].barTintColor = [UIColor colorWithRed: 41.0/255.0 green:181.0/255.0 blue:46.0/255.0 alpha:1.0];
    [[self navigationController] navigationBar].tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)callTapped:(id)sender {
    NSString *phNo = @"0084978119199";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        [Util showConfirmAlert:@"Alert" message:@"Call facility is not available!!!" delegate:self];
    }
}

- (IBAction)mailTapped:(id)sender {
    // From within your active view controller
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;        // Required to invoke mailComposeController when send
        [mailCont setToRecipients:[NSArray arrayWithObject:@"vuhungphan@gmail.com "]];
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)facebookTapped:(id)sender {
    NSURL *fanPageURL = [NSURL URLWithString:@"fb://profile/1589132370"];
    if (![[UIApplication sharedApplication] canOpenURL:fanPageURL])
        fanPageURL = [NSURL URLWithString:@"www.facebook.com/1589132370"];
    
    [[UIApplication sharedApplication] openURL:fanPageURL];
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
