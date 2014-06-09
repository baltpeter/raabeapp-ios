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

}

- (UIImage *)imageForVtrArt:(NSString *)vtrColor
{
	UIGraphicsBeginImageContext(CGRectMake(0, 0, 25, 25).size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[self colorFromHexString:vtrColor] setFill];
    
	CGRect circleRect = CGRectMake(0, 0,
                                   CGRectMake(0, 0, 25, 25).size.width,
                                   CGRectMake(0, 0, 25, 25).size.height);
	circleRect = CGRectInset(circleRect, 7, 7);
    CGContextFillEllipseInRect(ctx, circleRect);
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
    return retImage;
}

// taken from http://stackoverflow.com/a/12397366
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
