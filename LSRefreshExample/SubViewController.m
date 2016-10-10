//
//  SubViewController.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/10/9.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "SubViewController.h"
#import "LSRefresh.h"

@interface SubViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) LSRefreshHeader *refreshHeader;
@property (strong, nonatomic) LSRefreshFooter *refreshFooter;

@property (strong, nonatomic) LSRefreshNativeHeader *refreshNativeHeader;
@property (strong, nonatomic) LSRefreshAutoFooter *refreshAutoFooter;

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [UIView new];
    for (NSUInteger i = 0; i < 5; i++) {
        [self.dataSource addObject:@"1"];
    }
    
    __weak typeof(self) weakSelf = self;
    
    if (self.type == 0 || self.type == 4) {
        self.refreshHeader = [LSRefreshHeader headerWithActionBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf addMoreData];
                [strongSelf.tableView reloadData];
                [strongSelf.refreshHeader endRefreshing];
            });
        }];
        [self.tableView addSubview:self.refreshHeader];
    }
    
    if (self.type == 1 || self.type == 4) {
        self.refreshFooter = [LSRefreshFooter footerWithActionBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf addMoreData];
                [strongSelf.tableView reloadData];
                [strongSelf.refreshFooter endRefreshing];
            });
        }];
        [self.tableView addSubview:self.refreshFooter];
    }
    
    if (self.type == 2 || self.type == 5) {
        self.refreshNativeHeader = [LSRefreshNativeHeader nativeHeaderWithActionBlock:^{
            NSLog(@"trigger native header action");
            __strong typeof(weakSelf) strongSelf = weakSelf;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf addMoreData];
                [strongSelf.tableView reloadData];
                [strongSelf.refreshNativeHeader endRefreshing];
            });
        }];
        [self.tableView addSubview:self.refreshNativeHeader];
        
    }
    
    if (self.type == 3 || self.type == 5) {
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
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.refreshHeader) {
        [self.refreshHeader beginRefreshing];
    }
    
    if (self.refreshNativeHeader) {
        [self.refreshNativeHeader beginRefreshing];
    }
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
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"test %@", @(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

@end
