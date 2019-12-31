//
//  WeatherSearchController.m
//  WeatherApp
//
//  Created by Luca Faggion on 29/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherSearchController.h"
#import "WeatherSearchResultController.h"
#import "WeatherAppModel.h"

@interface WeatherSearchController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (strong, nonnull) UISearchController* searchController;
@property (strong, nonnull) WeatherSearchResultController* searchResultController;
@end

@implementation WeatherSearchController

#pragma mark - Controller Life Cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    //MARK: Search Result Controller (Table View) SETUP
    self.searchResultController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherSearchResultController"];
    [self addChildViewController:self.searchResultController];
    [self.view addSubview:self.searchResultController.view];
    
    //MARK: SearchController SETUP
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.navigationItem.searchController = self.searchController;
    self.searchController.searchResultsUpdater = self;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;

    self.definesPresentationContext = YES;
}

#pragma mark - UISearchResultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    // TODO: Update results
    NSString* searchText = searchController.searchBar.text;
    searchText = [searchText stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray* searchItems = [searchText componentsSeparatedByString:@","];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(searchItems.count == 1){
            if(![searchItems[0] isEqualToString:@""]){
                NSArray* test = [[[WeatherAppModel sharedModel] getDatabase] getCitiesbyPartialName:searchItems[0]];
                NSLog(@"%lu", test.count);
            }
        }else if(searchItems.count == 2){
            if([searchItems[1] isEqualToString:@""]){
                NSArray* test = [[[WeatherAppModel sharedModel] getDatabase] getCitiesbyPartialName:searchItems[0]];
                NSLog(@"%lu", test.count);
            }else{
                NSArray* test = [[[WeatherAppModel sharedModel] getDatabase] getCitiesbyPartialName:searchItems[0] ofCountry:searchItems[1]];
                NSLog(@"%lu", test.count);
            }
        }

        // update UI on the main thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//        });
        
    });

}
@end
