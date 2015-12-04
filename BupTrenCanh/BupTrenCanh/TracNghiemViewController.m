//
//  TracNghiemViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "TracNghiemViewController.h"

@interface TracNghiemViewController () {
    NSMutableArray *arrayData;
    NSMutableArray *currentData;
    NSMutableArray *question;
    NSString *correctAnswer;
    NSDictionary *data;
    int countPlay;
    int countError;
    int randomIndex;
    int bound;
    QuizPopOverViewController *quizPopOver;
}
@property (weak, nonatomic) IBOutlet UITextView *txtQuiz;
@property (weak, nonatomic) IBOutlet UIView *viewButton1;
@property (weak, nonatomic) IBOutlet UIView *viewButton2;
@property (weak, nonatomic) IBOutlet UIView *viewButton3;
@property (weak, nonatomic) IBOutlet UIView *viewButton4;
@property (weak, nonatomic) IBOutlet UIButton *btnText1;
@property (weak, nonatomic) IBOutlet UIButton *btnText2;
@property (weak, nonatomic) IBOutlet UIButton *btnText3;
@property (weak, nonatomic) IBOutlet UIButton *btnText4;
@property (weak, nonatomic) IBOutlet UILabel *lblMark;
@property (weak, nonatomic) IBOutlet UIImageView *imgLife1;
@property (weak, nonatomic) IBOutlet UIImageView *imgLife2;
@property (weak, nonatomic) IBOutlet UIImageView *imgLife3;
//@property (nonatomic, strong) NSMutableArray *arrayData;
//@property (nonatomic, strong) NSMutableArray *currentData;
//@property (nonatomic, strong) NSString *correctAnswer;
//@property (assign, nonatomic) int countPlay;
//@property (assign, nonatomic) int countError;
//@property (assign, nonatomic) int randomIndex;
//@property (assign, nonatomic) int bound;
//@property (nonatomic, strong) NSDictionary *data;
@end

@implementation TracNghiemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationController] navigationBar].barTintColor = [UIColor colorWithRed: 41.0/255.0 green:181.0/255.0 blue:46.0/255.0 alpha:1.0];
    [[self navigationController] navigationBar].tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self initData];
    [self setBorderOfView:self.viewButton1];
    [self setBorderOfView:self.viewButton2];
    [self setBorderOfView:self.viewButton3];
    [self setBorderOfView:self.viewButton4];
    
    quizPopOver = [[QuizPopOverViewController alloc] init];
    quizPopOver.delegate = self;
    countPlay = 0;
    countError = 3;
    [self randomQuestion];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextQuestion) name:@"nextQuiz" object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"nextQuiz" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    arrayData = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Quiz" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    for (int j = 1; j < [dict count]; j++) {
        NSArray *arrTemp = [dict allKeys];
        NSArray *root = [dict objectForKey:[arrTemp objectAtIndex:j]];
        question = [[NSMutableArray alloc] init];
        for (int i = 0; i < root.count; i++) {
            NSString *answer = root[i];
            [question addObject:answer];
        }
        [arrayData addObject:question];
    }
}

#pragma mark Each Question
- (void) randomQuestion {
    bound = (int)arrayData.count - countPlay;
    if (bound < 1) {
        [self isWin];
    } else {
        randomIndex = (int)arc4random() % bound;
        if (randomIndex >=0 && randomIndex <= arrayData.count) {
            currentData = [arrayData objectAtIndex:randomIndex];
            if ([[currentData objectAtIndex:1] isEqualToString:@""] && [[currentData objectAtIndex:4] isEqualToString:@""]) {
                [self.viewButton1 setHidden:YES];
                [self.viewButton4 setHidden:YES];
            } else {
                [self.viewButton1 setHidden:NO];
                [self.viewButton4 setHidden:NO];
            }
            self.txtQuiz.text = [currentData objectAtIndex:5];
            [self.btnText1 setTitle:[currentData objectAtIndex:1] forState:UIControlStateNormal];
            [self.btnText2 setTitle:[currentData objectAtIndex:2] forState:UIControlStateNormal];
            [self.btnText3 setTitle:[currentData objectAtIndex:3] forState:UIControlStateNormal];
            [self.btnText4 setTitle:[currentData objectAtIndex:4] forState:UIControlStateNormal];
            correctAnswer = [currentData objectAtIndex:0];
        } else {
            [self randomQuestion];
        }
        
    }
}

- (void) nextQuestion {
    if (countError == 0) {
        [self isDie];
    }
    [self.viewButton1 setBackgroundColor:[UIColor whiteColor]];
    [self.viewButton2 setBackgroundColor:[UIColor whiteColor]];
    [self.viewButton3 setBackgroundColor:[UIColor whiteColor]];
    [self.viewButton4 setBackgroundColor:[UIColor whiteColor]];
    [self.btnText1 setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
    [self.btnText2 setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
    [self.btnText3 setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
    [self.btnText4 setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
    [self randomQuestion];
}

- (void) rightQuestion:(UIView *)view {
    if ([[currentData objectAtIndex:6] isEqualToString:@""]) {
        [self nextQuestion];
    } else {
        NSString *reason = [currentData objectAtIndex:6];
        [self showPopUpWithReason:reason];
    }
    [self countMark];
}

- (void) wrongQuestion:(UIView *)view {
    view.backgroundColor = COLOR_WRONG;
    countError--;
    [self lostLife:countError];
}

- (void) setBorderOfView:(UIView *)view {
    view.layer.borderWidth = 2;
    view.layer.borderColor = COLOR_BORDER.CGColor;
    view.layer.cornerRadius = 5.0;
}
#pragma mark Life
- (void) countMark {
    countPlay++;
    
    self.lblMark.text = [NSString stringWithFormat:@"%d",countPlay];
}

- (void) lostLife:(int) life { //Xử lý hình ảnh khi trả lời sai
    switch (life) {
        case 0:
        {
            self.imgLife3.image = [UIImage imageNamed:@"heart_icon_grey"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self isDie];
                
            });
        }
            break;
        case 1:
            self.imgLife2.image = [UIImage imageNamed:@"heart_icon_grey"];
            break;
        case 2:
            self.imgLife1.image = [UIImage imageNamed:@"heart_icon_grey"];
            break;
        default:
            break;
    }
}

- (void) isDie {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thua" message:@"Bạn có muốn chơi lại ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imgLife1.image = [UIImage imageNamed:@"heart_icon_red"];
        self.imgLife2.image = [UIImage imageNamed:@"heart_icon_red"];
        self.imgLife3.image = [UIImage imageNamed:@"heart_icon_red"];
        countError = 3;
        countPlay = 0;
        self.lblMark.text = @"0";
        [self nextQuestion];
    }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void) isWin {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thắng" message:@"Bạn có muốn chơi lại ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imgLife1.image = [UIImage imageNamed:@"heart_icon_red"];
        self.imgLife2.image = [UIImage imageNamed:@"heart_icon_red"];
        self.imgLife3.image = [UIImage imageNamed:@"heart_icon_red"];
        countError = 3;
        countPlay = 0;
        self.lblMark.text = @"0";
        [self nextQuestion];
    }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Action View
- (IBAction)btn1:(UIButton *)sender {
    if ([correctAnswer isEqualToString:@"1"]) {
        [self rightQuestion:self.viewButton1];
    } else {
        [self wrongQuestion:self.viewButton1];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)btn2:(UIButton *)sender {
    if ([correctAnswer isEqualToString:@"2"]) {
        [self rightQuestion:self.viewButton2];
    } else {
        [self wrongQuestion:self.viewButton2];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)btn3:(UIButton *)sender {
    if ([correctAnswer isEqualToString:@"3"]) {
        [self rightQuestion:self.viewButton3];
    } else {
        [self wrongQuestion:self.viewButton3];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)btn4:(UIButton *)sender {
    if ([correctAnswer isEqualToString:@"4"]) {
        [self rightQuestion:self.viewButton4];
    } else {
        [self wrongQuestion:self.viewButton4];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark Show PopUp
- (void) showPopUpWithReason:(NSString *)reason {
        quizPopOver = [[QuizPopOverViewController alloc] initWithNibName:@"QuizPopOverViewController" bundle:nil];
        quizPopOver.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [quizPopOver showInView:YES aView:self.view reason:reason];
}

- (void)buttonCloseTapped {
    [self nextQuestion];
}
@end
