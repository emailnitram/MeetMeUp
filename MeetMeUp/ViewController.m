//
//  ViewController.m
//  MeetMeUp
//
//  Created by Martin Henry on 11/10/15.
//  Copyright © 2015 Martin Henry. All rights reserved.
//

#import "ViewController.h"
#import "EventDetailViewController.h"
#import "Event.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property NSArray *events;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.color = [UIColor magentaColor];
    self.activityIndicator.hidesWhenStopped = YES;
    [self loadEventsFromMeetUpApiWithQuery:@"mobile"];
}

- (void)loadEventsFromMeetUpApiWithQuery:(NSString *)query {
    [self.activityIndicator startAnimating];
    [Event retrieveMeetUpDataWithQuery:query andCompletion:^(NSArray *eventData) {
        self.events = eventData;
        [self.tableView reloadData];
        self.title = [NSString stringWithFormat:@"%lu results for %@", (unsigned long)self.events.count, query];
        [self.activityIndicator stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    Event *event = self.events[indexPath.row];
    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.address;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"eventDetailSegue" sender:self.events[indexPath.row]];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self loadEventsFromMeetUpApiWithQuery:searchBar.text];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     EventDetailViewController *destination = [segue destinationViewController];
     destination.event = sender;
 }
 

@end
