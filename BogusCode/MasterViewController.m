//
//  MasterViewController.m
//  BogusCode
//
//  Created by Johnny Blockingcall on 6/26/15.
//  Copyright (c) 2015 Vimeo. All rights reserved.
//

#define kOneConstant 1
#define vimeoBrandBlueColor [UIColor colorWithRed:26.0/255.0 green:183.0/255.0 blue:234.0/255.0 alpha:1.0]


#import "MasterViewController.h"

@interface MasterViewController () <NSURLConnectionDelegate>

@property NSMutableArray *objects;
@property NSMutableArray *pictures;
@property UITableView *tableView;

@end


@implementation MasterViewController


- (void)viewDidLoad
{
    self.objects = [NSMutableArray arrayWithCapacity:1000];
    self.pictures = [NSMutableArray arrayWithCapacity:1000];
    
    [self setupNavigationBarUI]; 
}


- (void)viewDidAppear:(BOOL)animated
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.vimeo.com/channels/staffpicks/videos"]];
    [request setValue:@"bearer b8e31bd89ba1ee093dc6ab0f863db1bd" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [NSString stringWithCString:[response bytes] encoding:NSUTF8StringEncoding];
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    self.objects = resDict[@"data"];
    
    NSLog(@"found %li objects", resDict.count);
    
    [self.tableView reloadData];
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


#pragma mark TableViewDelegate methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kOneConstant;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView = tableView;
    
    return 1000;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:self.view.bounds];
    
    @try
    {
        NSObject *object = [self.objects objectAtIndex:indexPath.row];
        cell.textLabel.text = [object valueForKey:@"name"];
        
        NSString *url = [[[[object valueForKey:@"pictures"] valueForKey:@"sizes"] objectAtIndex:0] valueForKey:@"link"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        cell.image = image;
    }
    @catch (NSException *exception)
    {
        cell.text = @"no more videos, scroll up...";
    }
    
    return cell;
}


@end
