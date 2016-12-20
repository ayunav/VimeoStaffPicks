//
//  VSPDetailViewController.m
//  BogusCode
//
//  Created by Ayuna NYC on 6/2/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import "VSPDetailViewController.h"

@interface VSPDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;
@property (weak, nonatomic) IBOutlet UIWebView *videoDescriptionWebView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *videoEmbedHTML;

@end

@implementation VSPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *videoEmbedFilePath = [[NSBundle mainBundle] pathForResource:@"videoEmbed" ofType:@"html"];
    NSError *err; 
    self.videoEmbedHTML = [NSString stringWithContentsOfFile:videoEmbedFilePath encoding:NSUTF8StringEncoding error:&err];
    
    self.videoWebView.scalesPageToFit = YES;
    self.videoWebView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSString *html = [self.videoEmbedHTML stringByReplacingOccurrencesOfString:@"<embeddedVideo>" withString:self.video.videoLink];
    [self.videoWebView loadHTMLString:html baseURL:nil];
  
    [self.videoDescriptionWebView loadHTMLString:[self.video.videoDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
}


@end
