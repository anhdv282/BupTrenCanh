//
//  QuyenVaBonPhanViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "QuyenVaBonPhanViewController.h"
#import "PDFViewController.h"

@interface QuyenVaBonPhanViewController ()<UITableViewDataSource, UITableViewDelegate> {
    WebViewPDFViewController *webView;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property NSArray *data;
@end

@implementation QuyenVaBonPhanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] navigationBar].barTintColor = [UIColor colorWithRed: 41.0/255.0 green:181.0/255.0 blue:46.0/255.0 alpha:1.0];
    [[self navigationController] navigationBar].tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.data = [NSArray arrayWithObjects:@"CongUocLHQVeQuyenTreEm1989",@"LuatBVCSGDTE",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"childrenRightCell"];
    UILabel *label = [[UILabel alloc] init];
    label = [cell viewWithTag:1];
    NSString *text;
    switch (indexPath.row) {
        case 0:
            text = @"Công ước Liên Hợp Quốc về quyền trẻ em";
            break;
        case 1:
            text = @"Luật chăm sóc giáo dục và bảo vệ trẻ em";
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
//    PDFViewController* viewController = [[PDFViewController alloc] init];
//    
//    [self.navigationController pushViewController:viewController animated:YES];
    webView = [[WebViewPDFViewController alloc] initWithNibName:@"WebViewPDFViewController" bundle:nil];
    webView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [webView showInView:YES aView:self.view reason:[self.data objectAtIndex:indexPath.row]];
}

- (void) didChooseAtIndex:(NSInteger)index{
    PDFViewController *pdfVC = [[PDFViewController alloc] init];
    pdfVC.index = index;
    [self.navigationController pushViewController:pdfVC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewFromRight"]) {
//        PDFViewController *detailViewController = [segue destinationViewController];
    }
}
@end
