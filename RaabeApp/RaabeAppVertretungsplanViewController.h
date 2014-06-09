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
@property (nonatomic) NSInteger selectedTableRow;

@end
