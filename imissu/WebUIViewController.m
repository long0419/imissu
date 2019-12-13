//
//  WebUIViewController.m
//  imissu
//
//  Created by long-laptop on 16/3/18.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "WebUIViewController.h"

@interface WebUIViewController (){
    UIWebView *webView ;
}
@end

@implementation WebUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, kScreen_Width, kScreen_Height)];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.delegate = self ;
    [self.view addSubview:webView];
    
    
    NSURL* url = [NSURL URLWithString:@"http://loltube.cn/missu"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20  , 20 , 30, 20)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
