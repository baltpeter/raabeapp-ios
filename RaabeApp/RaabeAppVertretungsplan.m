//
//  RaabeAppVertretungsplan.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 07.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretungsplan.h"

@implementation RaabeAppVertretungsplan

// only call asyncronously (ex.: http://stackoverflow.com/a/8091994)
- (void)getVertretungsplanWithFilter:(NSString *)filter
{
    // not a nice solution, I know...
    if(filter == nil) {
        filter = @"";
    }
    
    BOOL networkErrorAlertShown = false;
    
    NSString *password = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    NSString *urlString = [NSString stringWithFormat:@"%s%@%s%@", "http://oneloveforlife.de/rs/api.php?format=json&password=", password, "&date=web&filter=", filter];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@""]];    
    NSError *downloadError;
    NSData *vertretungsplanData = [[NSData alloc] initWithContentsOfURL: url options:NSDataReadingUncached error:&downloadError];
    
    if(downloadError) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Netzwerkfehler"
                              message:downloadError.localizedDescription
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil];
        [alert show];
        
        networkErrorAlertShown = true;
    }
    else {
        if([[[NSString alloc] initWithData:vertretungsplanData encoding:NSUTF8StringEncoding] isEqualToString:@"[wrong_pw]"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Falsches Passwort"
                                  message:@"Das eingebene Passwort ist nicht korrekt. Bitte ändern Sie es in den Einstellungen."
                                  delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    if(vertretungsplanData.description == nil) {
        if(!networkErrorAlertShown) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Netzwerkfehler"
                                  message:@"Ein unerwarteter Netzwerkfehler ist aufgetreten. Bitte versuchen Sie es später erneut."
                                  delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSError *jsonParsingError = nil;
        _vertretungsplan = [NSJSONSerialization JSONObjectWithData:vertretungsplanData options:0 error:&jsonParsingError];
    }
    
    NSArray *vplanData = [_vertretungsplan objectForKey:@"data"];
    
    for(int i = 0; i < vplanData.count; i++) {
        if(![[[vplanData objectAtIndex:i] objectForKey:@"klassen"] isEqualToString:@""]) {
            if([_sortedVertretungsplan objectForKey:[[vplanData objectAtIndex:i] objectForKey:@"klassen"]]) {
                [[_sortedVertretungsplan objectForKey:[[vplanData objectAtIndex:i] objectForKey:@"klassen"]] addObject:[vplanData objectAtIndex:i]];
                NSLog(@"already in array: %@", [[vplanData objectAtIndex:i] objectForKey:@"klassen"]);
            }
            else {
                NSMutableArray *toInsert = [[NSMutableArray alloc] init];
                [toInsert addObject:[vplanData objectAtIndex:i]];
                NSLog(@"not in array: %@", [[vplanData objectAtIndex:i] objectForKey:@"klassen"]);
                [_sortedVertretungsplan setObject:toInsert forKey:[[vplanData objectAtIndex:i] objectForKey:@"klassen"]];
            }
        }
    }
    
    _sortedVertretungsplanKeys = [_sortedVertretungsplan allKeys];
}

@end