//
//  Event.m
//  MeetMeUp
//
//  Created by Martin Henry on 11/10/15.
//  Copyright © 2015 Martin Henry. All rights reserved.
//

#import "Event.h"

@implementation Event

+ (void)retrieveMeetUpDataWithQuery:(NSString *)query andCompletion:(void (^)(NSArray *))complete {
    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=94117&text=%@&time=,1w&key=37296d407f1e63f4376d6b63951", query];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *events = [[NSMutableArray alloc] init];
        NSDictionary *responseData;
        responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *results = [responseData objectForKey:@"results"];
        
        for (NSDictionary *result in results) {
            NSDictionary *venue = [result objectForKey:@"venue"];
            Event *event = [[Event alloc] init];
            event.name = [result objectForKey:@"name"];
            event.address = [NSString stringWithFormat:@"%@, %@", [venue objectForKey:@"address_1"], [venue objectForKey:@"city"]];
            event.rsvpCounts = [result objectForKey:@"yes_rsvp_count"];
            event.eventDescription = [result objectForKey:@"description"];
            event.host = [venue objectForKey:@"name"];
            [events addObject:event];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete (events);
        });
    }];
    
    [task resume];
}
@end
