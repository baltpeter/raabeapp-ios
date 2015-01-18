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
#import "RaabeAppVertretungsplanDelegate.h"

@interface RaabeAppHomeViewController : UIViewController <RaabeAppVertretungsplanDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSDictionary *vertretungsplan;
@property (nonatomic, strong) NSMutableDictionary *sortedVertretungsplan;
@property (nonatomic, strong) NSArray *sortedVertretungsplanKeys;
@property (nonatomic) NSInteger selectedTableRow;
@property (nonatomic) NSInteger selectedTableSection;

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UITextView *informationenLabel;
@property (weak, nonatomic) IBOutlet UILabel *datumLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

- (void)receiveNewVertretungsplan:(RaabeAppVertretungsplan *)vertretungsplan;

@end
