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

//@property (strong, nonatomic) LSRefreshHeader *refreshHeader;
//@property (strong, nonatomic) LSRefreshFooter *refreshFooter;

@property (strong, nonatomic) LSRefreshNativeHeader *refreshNativeHeader;
@property (strong, nonatomic) LSRefreshAutoFooter *refreshAutoFooter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [UIView new];
    [self addMoreData];
    
    __weak typeof(self) weakSelf = self;
    self.refreshNativeHeader = [LSRefreshNativeHeader nativeHeaderWithActionBlock:^{
        NSLog(@"trigger native header action");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.refreshNativeHeader endRefreshing];
        });
    }];
    [self.tableView addSubview:self.refreshNativeHeader];
    
    self.refreshAutoFooter = [LSRefreshAutoFooter autoFooterWithActionBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"trigger auto footer action");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf addMoreData];
            [strongSelf.tableView reloadData];
            [strongSelf.refreshAutoFooter endRefreshing];
        });
    }];
    [self.tableView addSubview:self.refreshAutoFooter];


    
//    __weak typeof(self) weakSelf = self;
//    self.refreshHeader = [LSRefreshHeader headerWithActionBlock:^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [strongSelf.refreshHeader endRefreshing];
//        });
//    }];
//    [self.tableView addSubview:self.refreshHeader];
//    
//    self.refreshFooter = [LSRefreshFooter footerWithActionBlock:^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf addMoreData];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [strongSelf.refreshFooter endRefreshing];
//            [strongSelf.tableView reloadData];
//        });
//    }];
//    [self.tableView addSubview:self.refreshFooter];
}

- (void)addMoreData {
    for (NSUInteger i = 0; i < 10; i++) {
        [self.dataSource addObject:@"1"];
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
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
    cell.textLabel.text = [NSString stringWithFormat:@"test %@", @(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

@end
