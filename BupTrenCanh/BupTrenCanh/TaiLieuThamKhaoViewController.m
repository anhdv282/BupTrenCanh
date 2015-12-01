//
//  TaiLieuThamKhaoViewController.m
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "TaiLieuThamKhaoViewController.h"
#import "PDFViewController.h"
@interface TaiLieuThamKhaoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property NSArray *data;
@end

@implementation TaiLieuThamKhaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.data = [NSArray arrayWithObjects:@"CongUocLHQVeQuyenTreEm1989",@"LuatBVCSGDTE",nil];
    NSLog(@"%@",self.data);
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
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"childrenRightCell"];
    UILabel *label = [cell viewWithTag:1];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self didChooseAtIndex:indexPath.row];
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
