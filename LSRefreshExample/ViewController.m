//
//  ViewController.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/12.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "ViewController.h"
#import "LSRefresh.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LSRefreshHeader *refreshHeader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.refreshHeader = [LSRefreshHeader headerWithActionBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"trigger action block！！！！！！");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.refreshHeader endRefreshing];
        });
    }];
    [self.tableView addSubview:self.refreshHeader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"test %@", @(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

@end
