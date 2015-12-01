//
//  QuizPopOverViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "QuizPopOverViewController.h"

@interface QuizPopOverViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtReason;
@property (weak, nonatomic) IBOutlet UIButton *btnCloseView;
@property (weak, nonatomic) IBOutlet UIView *viewPopUp;

@end

@implementation QuizPopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.viewPopUp.layer.cornerRadius = 5;
    self.viewPopUp.layer.shadowOpacity = 0.8;
    self.viewPopUp.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.btnCloseView.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClose:(id)sender {
//    if (self.delegate != nil) {
        [self.delegate buttonCloseTapped];
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextQuiz" object:nil userInfo:nil];
    [self removeAnimate];
}

#pragma mark Animation View
- (void)showAnimate {
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
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

- (void)showInView:(BOOL)animated aView:(UIView *)aView reason:(NSString *)reason{
    [aView addSubview:self.view];
    self.txtReason.text = reason;
    if (animated)
    {
        [self showAnimate];
    }
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
