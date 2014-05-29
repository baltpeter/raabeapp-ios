//
//  RaabeAppGenericTableViewController.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 06.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppGenericTableViewController.h"

@implementation RaabeAppGenericTableViewController

- (void) viewDidLoad
{
    _vtrArtToUiColor = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1], @"Entfall",
                        [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1], @"Betreuung",
                        [UIColor colorWithRed:0.89 green:0.267 blue:0.584 alpha:1], @"Sondereinsatz",
                        [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1], @"verlegt",
                        [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1], @"verlegt von",
                        [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1], @"Tausch",
                        [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1], @"Freisetzung",
                        [UIColor colorWithRed:0.945 green:0.769 blue:0.059 alpha:1], @"Teil-Vertretung",
                        [UIColor colorWithRed:0.584 green:0.647 blue:0.651 alpha:1], @"Raum-Vertretung",
                        [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1], @"Pausenaufsicht",
                        [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1], @"Lehrertausch",
                        [UIColor colorWithRed:0.902 green:0.494 blue:0.133 alpha:1], @"Klausur",
                        [UIColor colorWithRed:0.945 green:0.769 blue:0.059 alpha:1], @"Vertretung",
                        nil];
}

- (UIImage *)imageForVtrArt:(NSString *)vtrArt
{
	UIGraphicsBeginImageContext(CGRectMake(0, 0, 25, 25).size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[[_vtrArtToUiColor valueForKey:vtrArt] setFill];
    
	CGRect circleRect = CGRectMake(0, 0,
                                   CGRectMake(0, 0, 25, 25).size.width,
                                   CGRectMake(0, 0, 25, 25).size.height);
	circleRect = CGRectInset(circleRect, 7, 7);
    CGContextFillEllipseInRect(ctx, circleRect);
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
    return retImage;
}

@end
