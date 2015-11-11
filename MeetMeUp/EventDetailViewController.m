//
//  EventDetailViewController.m
//  MeetMeUp
//
//  Created by Martin Henry on 11/10/15.
//  Copyright © 2015 Martin Henry. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rsvpCountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@ RSVPs", self.event.rsvpCounts];
    self.navigationItem.backBarButtonItem.title = @"Back";
    self.rsvpCountsLabel.text = self.event.name;
    self.hostLabel.text = self.event.host;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.event.eventDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.eventDescriptionTextView.attributedText = attributedString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
