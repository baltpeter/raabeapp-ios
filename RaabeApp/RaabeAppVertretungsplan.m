//
//  RaabeAppVertretungsplan.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 07.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretungsplan.h"

@implementation RaabeAppVertretungsplan

// only call asyncronously (ex.: http://stackoverflow.com/a/8091994 )
- (void)getVertretungsplanWithFilter:(NSString *)filter
{
    // not a nice solution, I know...
    if(filter == nil) {
        filter = @"";
    }
    
    BOOL networkErrorAlertShown = false;
    
    NSString *password = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_password"];
    NSString *urlString = [NSString stringWithFormat:@"%s%@%s%@%s", "http://oneloveforlife.de/rs/api.php?format=json&password=", password, "&date=web&filter=", filter, "&client=ios"];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSError *downloadError;
    NSData *vertretungsplanData = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingUncached error:&downloadError];
    
    if(downloadError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"Network error", nil)
                                  message:downloadError.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil, nil];
            [alert show];
        });
        
        networkErrorAlertShown = true;
    }
    else {
        if([[[NSString alloc] initWithData:vertretungsplanData encoding:NSUTF8StringEncoding] isEqualToString:@"[wrong_pw]"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:NSLocalizedString(@"Wrong password", nil)
                                      message:NSLocalizedString(@"The password you entered is incorrect. Please change it in the settings panel.", nil)
                                      delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil, nil];
                [alert show];
            });
        }
    }
    
    if(vertretungsplanData.description == nil) {
        if(!networkErrorAlertShown) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:NSLocalizedString(@"Network error", nil)
                                      message:NSLocalizedString(@"An unexpected network error has occurred. Please try again later.", nil)
                                      delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil, nil];
                [alert show];
            });
            
            networkErrorAlertShown = true;
        }
    }
    else {
        NSError *jsonParsingError = nil;
        _vertretungsplan = [NSJSONSerialization JSONObjectWithData:vertretungsplanData options:0 error:&jsonParsingError];
    }
    
    NSArray *vplanData = [_vertretungsplan objectForKey:@"data"];
    NSMutableDictionary *sortedVertretungsplan = [[NSMutableDictionary alloc] init];
    NSMutableArray *sortedVertretungsplanKeys = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < vplanData.count; i++) {
        NSString *klassen = [[vplanData objectAtIndex:i] objectForKey:@"klassen"];
        if([klassen isEqualToString:@""]) {
            klassen = NSLocalizedString(@"--", nil);
        }
        if([sortedVertretungsplan objectForKey:klassen]) {
            [[sortedVertretungsplan objectForKey:klassen] addObject:[vplanData objectAtIndex:i]];
        }
        else {
            NSMutableArray *toInsert = [[NSMutableArray alloc] init];
            [toInsert addObject:[vplanData objectAtIndex:i]];
            [sortedVertretungsplan setObject:toInsert forKey:klassen];
            [sortedVertretungsplanKeys addObject:klassen];
        }
    }
    
    _sortedVertretungsplan = sortedVertretungsplan;
    _sortedVertretungsplanKeys = sortedVertretungsplanKeys;
}

@end