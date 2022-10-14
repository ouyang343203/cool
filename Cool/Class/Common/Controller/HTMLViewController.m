//
//  HTMLViewController.m
//  ergWallet
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  显示HTML

#import "HTMLViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

@interface HTMLViewController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;

@end

@implementation HTMLViewController

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)url {

    self = [super init];
    if (self) {
        self.title = title;
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _webView = [[WKWebView alloc] init];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    // 支持滑动返回
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    
    CGFloat nvhight = IPHONE_X ? kNavBarHeight : self.navigationController.navigationBar.bounds.size.height+20;
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, nvhight, self.view.bounds.size.width, 2)];
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.progressTintColor = kGreenColor;
    [self.navigationController.view addSubview:self.progressView];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    [self.bridge setWebViewDelegate:self];
    [self setBridgeAction];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(@(kSafeAreaBottomHeight));
    }];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [self.progressView removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
}

// 页面排版规范
#pragma mark - HTTP Method -- 网络请求

// 方法和方法之间空一行
#pragma mark - Delegate Method -- 代理方法
#pragma mark - UIWebViewDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat progress = [change[NSKeyValueChangeNewKey] floatValue];
        [self.progressView setProgress:progress animated:YES];
        if(progress == 1.0){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.progressView setProgress:0.0 animated:NO];
            });
        }
    }
}
#pragma mark - Private Method -- 私有方法
-(void)setBridgeAction {
    
    [self.bridge registerHandler:@"scanLeDevice" handler:^(id data, WVJBResponseCallback responseCallback) {//js传递数据给原生
    
        NSDictionary *diction = @{@"code":@"0",@"errMsg":@""};
        responseCallback(diction);
        [self.bridge callHandler:@"onFoundDevice" data:nil];//原生传递数据给js
    }];
    
}

#pragma mark - Public Method -- 公开方法


#pragma mark - Setter/Getter -- Getter尽量写出懒加载形式


@end
