//
//  Event.h
//  MeetMeUp
//
//  Created by Martin Henry on 11/10/15.
//  Copyright © 2015 Martin Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property NSString *name;
@property NSString *address;
@property NSString *rsvpCounts;
@property NSString *eventDescription;
@property NSString *host;
+ (void)retrieveMeetUpDataWithQuery:(NSString *)query andCompletion:(void (^)(NSArray *))complete;
@end
