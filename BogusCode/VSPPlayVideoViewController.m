//
//  VSPPlayVideoViewController.m
//  BogusCode
//
//  Created by Ayuna NYC on 6/2/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import "VSPPlayVideoViewController.h"

@interface VSPPlayVideoViewController ()

@end

@implementation VSPPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize screenSize = rect.size;
    
    UIWebView *videoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64,screenSize.width,screenSize.height)];
    videoWebView.autoresizesSubviews = YES;
    videoWebView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);

    videoWebView.scalesPageToFit = YES;
    videoWebView.contentMode = UIViewContentModeScaleAspectFit;

    videoWebView.backgroundColor = [UIColor whiteColor]; 
    
    [self.view addSubview:videoWebView];
    
    [videoWebView loadHTMLString:[self.video.videoLink description] baseURL:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
