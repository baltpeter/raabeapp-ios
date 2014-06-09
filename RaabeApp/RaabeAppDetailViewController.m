//
//  RaabeAppDetailViewController.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 06.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppDetailViewController.h"

@implementation RaabeAppDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    _stundeLabel.text = [_vertretung objectForKey:@"stunde"];
    _vertreterLabel.text = [_vertretung objectForKey:@"vtr_lehrer"];
    _artLabel.text = [[_vertretung objectForKey:@"vtr_art"] objectForKey:@"name"];
    _klassenLabel.text = [_vertretung objectForKey:@"klassen"];
    _raumLabel.text = [_vertretung objectForKey:@"fach"];
    _fachLabel.text = [_vertretung objectForKey:@"stunde"];
    _absenterLehrerLabel.text = [_vertretung objectForKey:@"absenter_lehrer"];
    _leNachLabel.text = [_vertretung objectForKey:@"le_nach"];
    _vtrTextLabel.text = [_vertretung objectForKey:@"vtr_text"];
}

@end
