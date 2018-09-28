//
//  BaseWebViewController.m
//  CreditCardHousekeeper
//
//  Created by Paul on 2017/11/20.
//  Copyright © 2017年 QingHu. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()
<
    WKNavigationDelegate,
    WKUIDelegate,
    WKScriptMessageHandler
>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, copy) NSString *loadurl;

@end

@implementation BaseWebViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.wkWebView = nil;
}

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        _loadurl = url;
    }
    return self;
}

-(id)initWithUrl:(NSString *)url title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        _loadurl = url;
        self.title = title;
    }
    return self;
}

-(id)initWithUrl:(NSString *)url title:(NSString *)title customNavView:(UIView *)customNavView
{
    self = [super init];
    if (self)
    {
        _loadurl = url;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBarButtonBack];
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height - 64)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.scrollView.bounces = NO;
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    [self.wkWebView sizeToFit];
    self.wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
    [[self.wkWebView configuration].userContentController addScriptMessageHandler:self name:@"NOWTaskSub"];
    [self.view addSubview:self.wkWebView];
    
    NSURL *url = [NSURL URLWithString:self.loadurl];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //code
    NSLog(@"name = %@, body = %@", message.name, message.body);
    NSURL *url = [NSURL URLWithString:message.body];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

//设置返回按钮
- (void)setLeftBarButtonBack
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"general_back"] style:UIBarButtonItemStyleDone target:self action:@selector(didBackButtonClicked)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

//返回按钮事件
- (void)didBackButtonClicked
{
    if(self.wkWebView.canGoBack)
    {
        [self.wkWebView goBack];
        [self.wkWebView reload];
    }
    else
    {
        [self presentBackAction];
    }
}

-(void)presentBackAction
{
    self.wkWebView = nil;
    if(self.navigationController.viewControllers.count <= 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pushBackAction
{
    [SVProgressHUD dismiss];
    if([self.wkWebView canGoBack])
    {
        [self.wkWebView goBack];
    }
    else
    {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        if(self.navigationController.viewControllers.count == 1)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loading"])
    {
        
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        self.title = self.wkWebView.title;
    }
    else if ([keyPath isEqualToString:@"URL"])
    {
        
    }
}

//失败
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [SVProgressHUD dismiss];
    NSLog(@"%@",error);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%@", navigationAction.request.URL);
    WKNavigationActionPolicy policy =WKNavigationActionPolicyAllow;
    /* 简单判断host，真实App代码中，需要更精确判断itunes链接 */
    NSString *url = [NSString stringWithFormat:@"%@", navigationAction.request.URL];
    if([url rangeOfString:@"tel"].length > 0)
    {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    }
    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] && [[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
        policy = WKNavigationActionPolicyCancel;
    }
    
    decisionHandler(policy);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD dismiss];
    //禁用webView加载网页的长按出现’拷贝’事件
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
}

//在dealloc 中取消监听
-(void)dealloc
{
    self.wkWebView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Receive Memory Warning");
}

@end
