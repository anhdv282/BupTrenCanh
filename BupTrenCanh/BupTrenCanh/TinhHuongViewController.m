//
//  TinhHuongViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "TinhHuongViewController.h"

@interface TinhHuongViewController () {
    NSMutableArray *arrayData;
    NSMutableArray *currentData;
    NSMutableArray *quiz;
    int randomIndex;
    QuestionPopOverViewController *quizPopOver;
}
@property (weak, nonatomic) IBOutlet UITextView *lblQuestion;
@property (weak, nonatomic) IBOutlet UIButton *resultBtn;

@end

@implementation TinhHuongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
