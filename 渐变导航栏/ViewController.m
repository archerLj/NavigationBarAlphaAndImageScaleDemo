//
//  ViewController.m
//  渐变导航栏
//
//  Created by archerLj on 16/4/20.
//  Copyright © 2016年 archerLj. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+navigatinSetting.h"

const CGFloat imageH = 150;
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.contentInset = UIEdgeInsetsMake(imageH + 64, 0, 0, 0);
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"boat.jpg"];
    self.imageView.frame = CGRectMake(0, -imageH, self.view.bounds.size.width, imageH);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill; // 关键：设置宽高比填充
    
    [self.mainTableView insertSubview:self.imageView atIndex:0];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setNavigationBarBackGroundColor:[UIColor whiteColor]];
    [self setNavigationBarAlpha:0.1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setText:@"Title"];
    [titleLabel setContentMode:UIViewContentModeCenter];
    [self.navigationItem setTitleView:titleLabel];
}

//*****************************************************************************/
#pragma mark - delegate
//*****************************************************************************/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ljljlj"];
    [cell setBackgroundColor:[UIColor redColor]];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    [self setNavigationBarAlpha:((imageH + 64 + offSetY) / imageH)];
    
    if (offSetY < - (imageH + 64)) {
        CGFloat offSetAdd = -(imageH + 64) - offSetY;
        CGRect frame = self.imageView.frame;
        frame.origin.y = -imageH - offSetAdd - 64;
        frame.size.height = imageH + offSetAdd + 64;
        self.imageView.frame = frame;
    }
}


//*****************************************************************************/
#pragma mark - getter setter
//*****************************************************************************/
-(UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}
@end
