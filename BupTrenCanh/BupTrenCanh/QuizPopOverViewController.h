//
//  QuizPopOverViewController.h
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "ViewController.h"
@protocol QuizPopOverDelegate <NSObject>
@required
- (void)buttonCloseTapped;

@end

@interface QuizPopOverViewController : UIViewController
- (void)showInView:(BOOL)animated aView:(UIView *)aView reason:(NSString *)reason;
@property (weak, nonatomic) id<QuizPopOverDelegate>  delegate;
@end

