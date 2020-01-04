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
@property (strong, atomic) NSMutableArray* citiesFound;
@end

@implementation WeatherSearchController

#pragma mark - Controller Life Cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    //MARK: Search Result Controller (Table View) SETUP
    self.searchResultController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherSearchResultController"];
    self.searchResultController.delegate = self;
    [self addChildViewController:self.searchResultController];
    [self.view addSubview:self.searchResultController.view];
    
    //MARK: SearchController SETUP
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchResultController.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.navigationItem.searchController = self.searchController;
    self.searchController.searchResultsUpdater = self;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;

    self.definesPresentationContext = YES;
}

#pragma mark - WeatherSearchDelegate
-(void) onSelectedCityFromSearch:(NSInteger)city_id{
    if(city_id != -1){
        [self.delegate onSelectedCityFromSearch:city_id];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UISearchResultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* searchText = searchController.searchBar.text;
    searchText = [searchText stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        NSArray* searchItems = [searchText componentsSeparatedByString:@","];
        if(![searchText isEqualToString:@""]){
            if(searchItems.count == 1){
                if(![searchItems[0] isEqualToString:@""]){
                    self.citiesFound = [self searchCityWithName:searchItems[0]];
                }
            }else if(searchItems.count == 2){
                if([searchItems[1] isEqualToString:@""]){
                    self.citiesFound = [self searchCityWithName:searchItems[0]];
                }else{
                    self.citiesFound = [self searchCityWithName:searchItems[0] ofCountry:searchItems[1]];
                }
            }
        }
        // update UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchResultController.data = [[NSMutableArray alloc] initWithArray:self.citiesFound copyItems:YES];
            [self.searchResultController.tableView reloadData];
            if(self.citiesFound.count > 0){
                [self.searchResultController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        });
    });
}

#pragma mark - Search Methods
-(NSMutableArray*) searchCityWithName:(NSString*)name{
    return [[NSMutableArray alloc] initWithArray:[[[WeatherAppModel sharedModel] getDatabase] getCitiesbyPartialName:name] copyItems:YES];
}

-(NSMutableArray*) searchCityWithName:(NSString*)name ofCountry:(NSString*)country{
    return [[NSMutableArray alloc] initWithArray:[[[WeatherAppModel sharedModel] getDatabase] getCitiesbyPartialName:name ofCountry:country] copyItems:YES];
}

@end
