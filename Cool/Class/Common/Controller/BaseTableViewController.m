//
//  BaseTableViewController.m
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//  UITableView控制器基类

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;                                   // 默认页码:第1页
    _pageSize = 15;                                // 默认每页显示条数
    _currentRefreshStatus = RefreshStatusPullDown; // 默认下拉刷新
}

#pragma mark 如果需要添加UITableView直接调用一下方法即可
- (UITableView *)setupTableViewWithDelegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate {
    return [self setupTableViewWithDelegate:delegate style:UITableViewStylePlain shouldRefresh:NO];
}

- (UITableView *)setupTableViewWithDelegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate style:(UITableViewStyle)style {
    return [self setupTableViewWithDelegate:delegate style:style shouldRefresh:NO];
}

- (UITableView *)setupTableViewWithDelegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate shouldRefresh:(BOOL)shouldRefresh {
    return [self setupTableViewWithDelegate:delegate style:UITableViewStylePlain shouldRefresh:shouldRefresh];
}

- (UITableView *)setupTableViewWithDelegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate style:(UITableViewStyle)style shouldRefresh:(BOOL)shouldRefresh {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = kBackgroundColor;
    tableView.separatorColor = kSeparateLineColor;
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.edges.equalTo(self.view);
        }
    }];

    if (shouldRefresh) {
        [self sutupRefreshComponent:tableView];
    }

    return tableView;
}

- (UITableView *)setupTableViewForView:(UIView *)superView frame:(CGRect)frame delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate style:(UITableViewStyle)style {
    return [self setupTableViewForView:superView frame:frame delegate:delegate style:style shouldRefresh:NO];
}

- (UITableView *)setupTableViewForView:(UIView *)superView frame:(CGRect)frame delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate style:(UITableViewStyle)style shouldRefresh:(BOOL)shouldRefresh {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.backgroundColor = kBackgroundColor;
    tableView.separatorColor = kSeparateLineColor;
    tableView.tableFooterView = [UIView new];
    [superView addSubview:tableView];

    if (shouldRefresh) {
        [self sutupRefreshComponent:tableView];
    }

    return tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kZeroHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kZeroHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];
}

// 下拉刷新回调
- (void)pullDownToRefresh {
    
    self.currentRefreshStatus = RefreshStatusPullDown;
    [self endRefreshingHeader];
    [self pullDownHandle];
}

// 子类重写该方法,请求数据
- (void)pullDownHandle {
}

// 上拉加载更多回调
- (void)pullUpToRefresh {
    
    self.currentRefreshStatus = RefreshStatusPullUp;
    [self endRefreshingFooter];
    [self pullUpHandle];
}

// 子类重写该方法,请求数据
- (void)pullUpHandle {
}

// 结束刷新
- (void)endRefreshingHeader {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)endRefreshingFooter {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}

// 是否显示头部刷新控件
- (void)showHeaderView:(BOOL)show {
    
    self.tableView.mj_header.hidden = !show;
}

// 是否显示尾部刷新控件
- (void)showFooterView:(BOOL)show {
    
    self.tableView.mj_footer.hidden = !show;
}

- (void)sutupRefreshComponent:(UITableView *)tableView {
    
    MJRefreshNormalHeader*mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self  pullDownToRefresh];
    }];
    tableView.mj_header =  mj_header;

    MJRefreshBackNormalFooter* mj_footer =  [MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        [self  pullUpToRefresh];
    }];
    tableView.mj_footer =  mj_footer;
}

@end
