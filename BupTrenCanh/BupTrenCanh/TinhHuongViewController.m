//
//  TinhHuongViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "TinhHuongViewController.h"
#import <Social/Social.h>
@interface TinhHuongViewController () {
    NSMutableArray *arrayData;
    NSMutableArray *currentData;
    NSMutableArray *quiz;
    int randomIndex;
    QuestionPopOverViewController *quizPopOver;
}
@property (weak, nonatomic) IBOutlet UITextView *lblQuestion;
@property (weak, nonatomic) IBOutlet UIButton *resultBtn;
@property (weak, nonatomic) IBOutlet UILabel *ads;

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
    [self randomQuiz];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"nextQuestion" object:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
