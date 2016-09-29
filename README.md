# LSRefresh

## DEMO
![demo](https://github.com/lsgbhp/LSRefresh/blob/master/demo.gif)

## Usage

1. import `LSRefresh.h`.
2. add header/footer to tableview, 	notice using `weakSelf` in action block.

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



