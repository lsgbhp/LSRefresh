# LSRefresh

## Demo
![demo](https://github.com/lsgbhp/LSRefresh/blob/master/demo.gif)

## Usage

1. 引用 `LSRefresh.h`.
2. 将 `header/footer` 添加至 `tableView/collectionView`， 注意在回调中需要使用 `weakSelf`避免循环使用。

```objc
__weak typeof(self) weakSelf = self;
	
self.refreshHeader = [LSRefreshHeader headerWithActionBlock:^{
	//To do something
	[weakSefl.tableView reloadData];
}];
[self.tableView addSubview:self.refreshHeader];
    
self.refreshFooter = [LSRefreshFooter footerWithActionBlock:^{
	//To do something
}];
[self.tableView addSubview:self.refreshFooter];
```



