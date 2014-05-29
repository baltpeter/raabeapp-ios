//
//  RaabeAppDetailViewController.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 06.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaabeAppGenericTableViewController.h"
#include "RaabeAppVertretung.h"

@interface RaabeAppDetailViewController : RaabeAppGenericTableViewController

@property (nonatomic) RaabeAppVertretung *vertretung;
@property (nonatomic) NSInteger currentRow;

@end
