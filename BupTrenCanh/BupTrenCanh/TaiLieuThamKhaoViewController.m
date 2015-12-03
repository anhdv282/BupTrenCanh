//
//  TaiLieuThamKhaoViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "TaiLieuThamKhaoViewController.h"
#import "PDFViewController.h"
@interface TaiLieuThamKhaoViewController ()<UITableViewDataSource, UITableViewDelegate> {
    WebViewPDFViewController *webView;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property NSArray *data;
@end

@implementation TaiLieuThamKhaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] navigationBar].barTintColor = [UIColor colorWithRed: 41.0/255.0 green:181.0/255.0 blue:46.0/255.0 alpha:1.0];
    [[self navigationController] navigationBar].tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.data = [NSArray arrayWithObjects:@"NHCHVTHVQTET1",@"NHCHVTHVQTET2",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"childrenRightCell"];
    UILabel *label = [cell viewWithTag:1];
    NSString *text;
    switch (indexPath.row) {
        case 0:
            text = @"Ngân hàng câu hỏi và tình huống về quyền trẻ em 1";
            break;
        case 1:
            text = @"Ngân hàng câu hỏi và tình huống về quyền trẻ em 2";
            break;
        default:
            break;
    }
    label.text = text;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [self didChooseAtIndex:indexPath.row];
    webView = [[WebViewPDFViewController alloc] initWithNibName:@"WebViewPDFViewController" bundle:nil];
    webView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [webView showInView:YES aView:self.view reason:[self.data objectAtIndex:indexPath.row]];
    
}

- (void) didChooseAtIndex:(NSInteger)index{
    PDFViewController *pdfVC = [[PDFViewController alloc] init];
    pdfVC.index = index;
    [self.navigationController pushViewController:pdfVC animated:YES];
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
