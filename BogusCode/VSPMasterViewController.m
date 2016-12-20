//
//  VSPMasterViewController.m
//  BogusCode
//
//  Created by Johnny Blockingcall on 6/26/15.
//  Copyright (c) 2015 Vimeo. All rights reserved.
//

#import "VSPMasterViewController.h"
#import "VSPNetworkModel.h"
#import "VSPVideo.h"
#import "VSPDetailViewController.h"
#import "VSPPlayVideoViewController.h"


#define kOneConstant 1
#define vimeoBrandBlueColor [UIColor colorWithRed:26.0/255.0 green:183.0/255.0 blue:234.0/255.0 alpha:1.0]


@interface VSPMasterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<VSPVideo *> *videos;
@property NSUInteger offset;

@end


@implementation VSPMasterViewController


- (void)viewDidLoad
{
    self.videos = [[NSMutableArray alloc] init];
    self.offset = 1;
    
    [self setupNavigationBarUI];
    [self fetchVideosWithOffset:self.offset];
}


- (void)setupNavigationBarUI
{
    self.navigationItem.title = @"Vimeo Staff Picks";
    
    // Vimeo brand color: http://brandcolors.net/ hex value: 1AB7EA hex to rgb: http://hex.colorrrs.com/ rgb(26,183,234)
    // my own StackOverflow answer to How can I create a UIColor from a hex string?: http://stackoverflow.com/a/33419207/5503769
    // http://stackoverflow.com/questions/599405/iphone-navigation-bar-title-text-color
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: vimeoBrandBlueColor};
    [self.navigationController.navigationBar setTintColor:vimeoBrandBlueColor];
}


- (void)fetchVideosWithOffset:(NSUInteger)offset
{
    VSPNetworkModel *networkModel = [VSPNetworkModel sharedNetworkModel];

    [networkModel fetchVideosWithOffset:offset andReturn:^(NSMutableArray<VSPVideo *> *videos)
    {
        [self.videos addObjectsFromArray:videos];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark TableViewDataSource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kOneConstant;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:self.view.bounds];
    
    @try
    {
        VSPVideo *video = self.videos[indexPath.row];
        
        cell.textLabel.text = video.name;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:video.imageURLlink]]];
        cell.imageView.image = image;
    }
    @catch (NSException *exception)
    {
        cell.textLabel.text = @"no more videos, scroll up...";
    }
    
    if (indexPath.row == self.videos.count - 1) {
        [self fetchVideosWithOffset:++self.offset];
    }

    return cell;
}


#pragma mark TableViewDelegate methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VSPDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VSPDetailViewController"];
    
    detailVC.video = self.videos[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
