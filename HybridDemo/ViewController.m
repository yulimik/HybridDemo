//
//  ViewController.m
//  HybridDemo
//
//  Created by 周伟 on 16/5/19.
//  Copyright © 2016年 yulimik. All rights reserved.
//

#import "ViewController.h"
#import "TemplateUtil.h"
#import <WebViewJavascriptBridge.h>

#define SCREEN_FRAME   [[UIScreen mainScreen] bounds]

#define SCREEN_WIDTH  SCREEN_FRAME.size.width

#define SCREEN_HEIGHT SCREEN_FRAME.size.height
@interface ViewController ()<WebViewJavascriptBridgeBaseDelegate,UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *testView;
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //获取html 字符 nil 参数可传递字典，并且在html模板做绑定
    NSString *foodCategoryHtml = [TemplateUtil loadHTMLByGRMustache:nil :@"testH"];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.testView loadHTMLString:foodCategoryHtml baseURL:baseURL];
    self.view = self.testView;
    
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btn setTitle:@"原生按钮" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(callHandlerNew) forControlEvents:UIControlEventTouchUpInside];
    self.btn.frame = CGRectMake(120, 300, 100, 50);
    [self.view insertSubview:self.btn aboveSubview:self.testView];
    
    self.label = [[UILabel alloc]init];
    [self.label setText:@"原生Label"];
    self.label.frame = CGRectMake(120, 380, 300, 50);
    [self.view insertSubview:self.label aboveSubview:self.testView];
    
    [self initJSBridge];
}

// 通信桥
- (void)initJSBridge {
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.testView];
    
    [self.bridge setWebViewDelegate:self];
    
    [self.bridge registerHandler:@"jsLetOcDo" handler:^(id data, WVJBResponseCallback responseCallback) {
        //从js获取数据
        NSLog(@"js call oc do something,data from js is %@",data);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"原生Alert" message:@"这是OC原生Alert" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSDate *time = [NSDate date];
        NSString * timeStr = [formatter stringFromDate:time];
        self.label.text = [[data objectForKey:@"blogURL"] stringByAppendingString:timeStr];
        if (responseCallback) {
            //反馈给JS
            responseCallback(@{@"testId":@"111111"});
        }
    }];
    
}

- (void)callHandlerNew {
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
