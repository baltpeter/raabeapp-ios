//
//  RaabeAppVertretungsplan.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 07.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RaabeAppVertretungsplan : NSObject

@property (nonatomic, strong) NSDictionary *vertretungsplan;

- (void)getVertretungsplanWithFilter:(NSString *)filter;

@end
