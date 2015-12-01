//
//  QuestionPopOverViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "QuestionPopOverViewController.h"

@interface QuestionPopOverViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtReason;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIView *viewPopUp;

@end

@implementation QuestionPopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.viewPopUp.layer.cornerRadius = 5;
    self.viewPopUp.layer.shadowOpacity = 0.8;
    self.viewPopUp.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.btnClose.layer.cornerRadius = 5;
    self.btnNext.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeTapped:(id)sender {
    [self removeAnimate];
}
- (IBAction)nextTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextQuestion" object:nil userInfo:nil];
    [self removeAnimate];
}

#pragma mark Animation View
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

- (void)showInView:(BOOL)animated aView:(UIView *)aView {
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.view];
    [currentWindow bringSubviewToFront:self.view];
    if (animated)
    {
        [self showAnimate];
    }
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
