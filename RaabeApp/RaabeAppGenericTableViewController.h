//
//  RaabeAppGenericTableViewController.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 06.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaabeAppGenericTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *vtrArtToUiColor;

- (UIImage *)imageForVtrArt:(NSString *)vtrArt;

@end
