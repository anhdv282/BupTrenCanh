//
//  TinhHuongViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//
@import GoogleMobileAds;
#import "TinhHuongViewController.h"
#import <Social/Social.h>
@interface TinhHuongViewController ()<GADInterstitialDelegate> {
    NSMutableArray *arrayData;
    NSMutableArray *currentData;
    NSMutableArray *quiz;
    NSTimer *timer;
    int randomIndex;
    QuestionPopOverViewController *quizPopOver;
}
@property (weak, nonatomic) IBOutlet UITextView *lblQuestion;
@property (weak, nonatomic) IBOutlet UIButton *resultBtn;
@property (weak, nonatomic) IBOutlet UILabel *ads;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation TinhHuongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] navigationBar].barTintColor = [UIColor colorWithRed: 41.0/255.0 green:181.0/255.0 blue:46.0/255.0 alpha:1.0];
    [[self navigationController] navigationBar].tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.ads setHidden:YES];
    [self initData];
    [self randomQuiz];
    [self createAndLoadInterstitial];
    self.resultBtn.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnswerTapped:(id)sender {
    [self showPopUpWithReason:[currentData objectAtIndex:1]];
}

- (void) showPopUpWithReason:(NSString *)reason {
    quizPopOver = [[QuestionPopOverViewController alloc] initWithNibName:@"QuestionPopOverViewController" bundle:nil];
    quizPopOver.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [quizPopOver showInView:YES aView:self.view reason:reason];
}

- (void)initData{
    arrayData = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Question" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    for (int j = 1; j < [dict count]; j++) {
        NSArray *arrTemp = [dict allKeys];
        NSArray *root = [dict objectForKey:[arrTemp objectAtIndex:j]];
        quiz = [[NSMutableArray alloc] init];
        for (int i = 0; i < root.count; i++) {
            NSString *answer = root[i];
            [quiz addObject:answer];
        }
        [arrayData addObject:quiz];
    }
}

- (void) randomQuiz {
    randomIndex = (int)arc4random_uniform((u_int32_t)(arrayData.count));
    currentData = [arrayData objectAtIndex:randomIndex];
    self.lblQuestion.text = [currentData objectAtIndex:0];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(randomQuiz) name:@"nextQuestion" object:nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showAds) userInfo:nil repeats:YES];
    [self randomQuiz];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"nextQuestion" object:nil];
    [timer invalidate];
}

- (IBAction)shareFacebook:(UIBarButtonItem *)sender {
    [self.ads setHidden:NO];
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        [tweet setInitialText:@"Initial tweet text."];
        [tweet addImage:image];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user sent the post.");
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                        message:@"Facebook integration is not available.  Make sure you have setup your Facebook account on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    [self.ads setHidden:YES];
}

- (void)showAds {
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
}

- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6761165209979255/3565510128"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADInterstitial automatically returns test ads when running on a
    // simulator.
//    request.testDevices = @[
//                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
//                            ];
//    request.testDevices = @[@"bbb31a285078a457dbfcb3484cce7ac662a4d9fc"];
    [self.interstitial loadRequest:request];
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
    [self randomQuiz];
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
