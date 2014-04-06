//
//  WIKViewController.m
//  Wick
//
//  Created by Bryan Irace on 4/6/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

#import "WIKViewController.h"
#import "WIKAPIClient.h"
#import "WIKTableViewCell.h"
#import <Ono/Ono.h>

@interface WIKViewController () <UISearchBarDelegate>

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) NSArray *items;

@end

@implementation WIKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchBar;
    
    [self.tableView registerClass:[WIKTableViewCell class] forCellReuseIdentifier:@"ID"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.contentInset = ({
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = 20;
        insets;
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ONOXMLElement *item = self.items[indexPath.row];
    WIKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    cell.textLabel.text = [[item firstChildWithTag:@"Text"] stringValue];
    cell.detailTextLabel.text = [[item firstChildWithTag:@"Description"] stringValue];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[[WIKAPIClient alloc] init] search:searchBar.text callback:^(ONOXMLDocument *document, NSError *error) {
        self.items = [[document.rootElement firstChildWithTag:@"Section"] childrenWithTag:@"Item"];
        
        [self.tableView reloadData];
    }];
}

@end
