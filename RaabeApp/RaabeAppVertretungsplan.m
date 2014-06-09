//
//  RaabeAppVertretungsplan.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 07.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretungsplan.h"

@implementation RaabeAppVertretungsplan

- (void)getVertretungsplanWithFilter:(NSString *)filter
{
    NSString *password = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    NSString *urlString = [NSString stringWithFormat:@"%s%@%s%@", "http://www.raabeschule.de/vplanupdate/api.php?format=json&password=", password, "&date=web&filter=", filter];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    NSData *vertretungsplanData = [[NSData alloc] initWithContentsOfURL: url];
    
    if([[[NSString alloc] initWithData:vertretungsplanData encoding:NSUTF8StringEncoding] isEqualToString:@"[wrong_pw]"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Falsches Passwort!"
                              message:@"Das eingebene Passwort ist nicht korrekt. Bitte ändern Sie es in den Einstellungen."
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSError *jsonParsingError = nil;
    _vertretungsplan = [NSJSONSerialization JSONObjectWithData:vertretungsplanData options:0 error:&jsonParsingError];
}

@end