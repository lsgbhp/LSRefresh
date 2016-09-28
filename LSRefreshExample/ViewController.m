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
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) LSRefreshHeader *refreshHeader;
@property (strong, nonatomic) LSRefreshFooter *refreshFooter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.refreshHeader = [LSRefreshHeader headerWithActionBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"trigger header action block！！！！！！");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.refreshHeader endRefreshing];
        });
    }];
    
    self.refreshFooter = [LSRefreshFooter footerWithActionBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"triiger footer action block！！！！！");
        for (NSUInteger i = 0; i < 10; i++) {
            [strongSelf.dataSource addObject:@"1"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.refreshFooter endRefreshing];
            [strongSelf.tableView reloadData];
            if (strongSelf.dataSource.count > 30) {
                strongSelf.refreshFooter.hidden = YES;
            }
        });
    }];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 10, 0);
    
    [self.tableView addSubview:self.refreshHeader];
    [self.tableView addSubview:self.refreshFooter];
    
    self.dataSource = [NSMutableArray new];
    for (NSUInteger i = 0; i < 10; i++) {
        [self.dataSource addObject:@"1"];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
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
