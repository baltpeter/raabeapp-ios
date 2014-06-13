//
//  RaabeAppVertretungsplanViewController.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaabeAppGenericTableViewController.h"
#import "RaabeAppDetailViewController.h"
#import "RaabeAppVertretungsplan.h"

@interface RaabeAppVertretungsplanViewController : RaabeAppGenericTableViewController

@property (nonatomic, strong) NSDictionary *vertretungsplan;
@property (nonatomic, strong) NSMutableDictionary *sortedVertretungsplan;
@property (nonatomic, strong) NSArray *sortedVertretungsplanKeys;
@property (nonatomic) NSInteger selectedTableRow;
@property (nonatomic) NSInteger selectedTableSection;

@end
