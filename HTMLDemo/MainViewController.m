//
//  MainViewController.m
//  HTMLDemo
//
//  Created by Devond on 16/4/29.
//  Copyright © 2016年 HZ. All rights reserved.
//

#import "MainViewController.h"
#import <DLPanableWebView/DLPanableWebView.h>

@interface MainViewController()<UIWebViewDelegate>

@property (nonatomic, strong)UISwipeGestureRecognizer    *swipeRight;

@property (nonatomic, strong)UISwipeGestureRecognizer    *swipeLeft;

@property (nonatomic, assign)BOOL                        isTablePage;

@end

@implementation MainViewController


- (void)viewDidLoad{
    self.title = @"帮助与反馈";
    DLPanableWebView *webView = [[DLPanableWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.64:90/c_table.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    
    
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonClicked)]];
//    self.navigationItem.hidesBackButton = YES;
}

- (void)backButtonClicked{
    if (_isTablePage) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"nott pop");
    }
    NSLog(@"--------");
}

-(void)swipe:(UISwipeGestureRecognizer *)g{
    if (g.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"---right");
    } else {
        NSLog(@"-----left");
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (pageTitle.length > 15) {
        pageTitle = [pageTitle substringToIndex:15];
        pageTitle = [pageTitle stringByAppendingString:@"..."];
    }
    self.title = pageTitle;
    if ([pageTitle isEqualToString:@"帮助与反馈"]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        _isTablePage = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        _isTablePage = NO;
    }
    NSLog(@"pageTitle---%@",pageTitle);
}

@end
