//
//  RaabeAppHomeViewController.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 08.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaabeAppVertretungCell.h"
#import "RaabeAppVertretungsplan.h"
#import "RaabeAppGenericTableViewController.h"
#import "RaabeAppDetailViewController.h"

@interface RaabeAppHomeViewController : UIViewController

@property (nonatomic, strong) NSDictionary *vertretungsplan;
@property (nonatomic) NSInteger selectedTableRow;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UITextView *informationenLabel;
@property (weak, nonatomic) IBOutlet UILabel *datumLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end
