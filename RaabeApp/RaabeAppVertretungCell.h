//
//  RaabeAppVertretungCell.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 04.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaabeAppVertretungCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *klasseLabel;
@property (nonatomic, weak) IBOutlet UIImageView *vtrArtImg;
@property (nonatomic, weak) IBOutlet UILabel *stundeLabel;
@property (nonatomic, weak) IBOutlet UILabel *vtrLehrerLabel;
@property (nonatomic, weak) IBOutlet UILabel *absenterLehrerLabel;
@property (nonatomic, weak) IBOutlet UILabel *vtrRaumLabel;
@property (nonatomic, weak) IBOutlet UILabel *vtrFachLabel;

@end
