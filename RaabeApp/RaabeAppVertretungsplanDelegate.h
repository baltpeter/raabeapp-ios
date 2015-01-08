//
//  RaabeAppVertretungsplanDelegate.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 08/01/15.
//  Copyright (c) 2015 Benjamin Altpeter. All rights reserved.
//
@class RaabeAppVertretungsplan;

@protocol RaabeAppVertretungsplanDelegate <NSObject>

@required
- (void)receiveNewVertretungsplan:(RaabeAppVertretungsplan *)vertretungsplan;

@end