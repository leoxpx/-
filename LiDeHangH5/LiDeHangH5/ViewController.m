//
//  ViewController.m
//  LiDeHangH5
//
//  Created by 杭州稳瞻信息科技有限公司 on 16/4/21.
//  Copyright © 2016年 xpx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIWebView *_webView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lidehang.com/mobile"]];
    
    [_webView loadRequest:request];
    
    NSLog(@"%@",_webView);
    
    [self.view addSubview:_webView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapListener:)];
    tap.delegate = self;
    [_webView addGestureRecognizer:tap];
    
    [self.view sendSubviewToBack:_webView];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"%@",@"开始");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成");
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    NSLog(@"%@",error);
}

- (IBAction)forward:(id)sender {
    
    if ([_webView canGoForward]) {
        [_webView goForward];
    }else{
        NSLog(@"不可前进");
    }
}
- (IBAction)back:(id)sender {
    
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        NSLog(@"不可后退");
    }
}


- (void)tapListener:(UITapGestureRecognizer *)ges
{
    CGPoint point = [ges locationInView:_webView];
    
    NSString *js_string = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).src", point.x, point.y];
    
    NSString *res = [_webView stringByEvaluatingJavaScriptFromString:js_string];
    
    if ([res length] > 0) {
        
        ViewController *vc = [[ViewController alloc] init];
        vc.view.backgroundColor = [UIColor redColor];
        [self presentViewController:vc animated:YES completion:nil];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
