//
//  RaabeAppVertretung.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretung.h"

@implementation RaabeAppVertretung

- (NSDictionary *) dictDescriptionToValue
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          _vtrArt, @"Vertretungsart",
                          _klasse, @"Klasse",
                          _datum, @"Datum",
                          _stunde, @"Stunde",
                          _absenterLehrer, @"Absenter Lehrer",
                          _vtrLehrer, @"Vertretender Lehrer",
                          _fach, @"Fach",
                          _vtrFach, @"Vertretungsfach",
                          _raum, @"Ursprünglicher Raum",
                          _vtrRaum, @"Vertretungsraum",
                          _vtrText, @"Vertretungstext",
                          nil];
    return dict;
}

@end
