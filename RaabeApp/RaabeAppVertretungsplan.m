//
//  RaabeAppVertretungsplan.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 07.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretungsplan.h"

@implementation RaabeAppVertretungsplan

- (void)getVertretungsplanWithFilter:(NSString *)filter AndInformDelegate:(id <RaabeAppVertretungsplanDelegate>)delegate
{
    if(filter == nil) { filter = @""; }
    
    NSString *password = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_password"];
    NSString *urlString = [NSString stringWithFormat:@"%s%@%s%@%s", "http://raabeschule.de/vplanupdate/api.php?format=json&password=", password, "&date=web&filter=", filter, "&client=ios"];
    NSLog(urlString);
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog([urlString stringByReplacingOccurrencesOfString:@" " withString:@""]);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        BOOL networkErrorAlertShown = false;
        
        if(error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:NSLocalizedString(@"Network error", nil)
                                      message:error.localizedDescription
                                      delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil, nil];
                [alert show];
            });
            
            networkErrorAlertShown = true;
        }
        else {
            if([[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] isEqualToString:@"[wrong_pw]"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:NSLocalizedString(@"Wrong password", nil)
                                          message:NSLocalizedString(@"The password you entered is incorrect. Please change it in the settings panel.", nil)
                                          delegate:delegate
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"Open Settings.app", nil), nil];
                    [alert setTag:401];
                    [alert show];
                });
            }
        }
        
        if(data.description == nil) {
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
            _vertretungsplan = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate receiveNewVertretungsplan:self];
        });
    }];
}

@end