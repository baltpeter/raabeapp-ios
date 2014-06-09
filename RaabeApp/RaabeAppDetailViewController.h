//
//  RaabeAppDetailViewController.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 06.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaabeAppGenericTableViewController.h"

@interface RaabeAppDetailViewController : RaabeAppGenericTableViewController

@property (weak, nonatomic) IBOutlet UILabel *stundeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vertreterLabel;
@property (weak, nonatomic) IBOutlet UILabel *artLabel;
@property (weak, nonatomic) IBOutlet UILabel *klassenLabel;
@property (weak, nonatomic) IBOutlet UILabel *raumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fachLabel;
@property (weak, nonatomic) IBOutlet UILabel *absenterLehrerLabel;
@property (weak, nonatomic) IBOutlet UILabel *leNachLabel;
@property (weak, nonatomic) IBOutlet UILabel *vtrTextLabel;

@property (nonatomic, strong) NSDictionary *vertretung;

@end
