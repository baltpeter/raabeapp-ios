//
//  RaabeAppVertretungsplanViewController.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretungsplanViewController.h"
#import "RaabeAppVertretung.h"
#import "RaabeAppVertretungCell.h"

@implementation RaabeAppVertretungsplanViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.vertretungen count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RaabeAppVertretungCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VertretungCell"];
    
    RaabeAppVertretung *vertretung = (self.vertretungen)[indexPath.row];
    
    cell.klasseLabel.text = vertretung.klasse;
    cell.stundeLabel.text = vertretung.stunde;
    cell.vtrLehrerLabel.text = vertretung.vtrLehrer;
    cell.absenterLehrerLabel.text = vertretung.absenterLehrer;
    cell.vtrRaumLabel.text = vertretung.vtrRaum;
    cell.vtrFachLabel.text = vertretung.vtrFach;
    
    UIImageView *vtrArtImg = (UIImageView *)[cell viewWithTag:101];
    vtrArtImg.image = [self imageForVtrArt:vertretung.vtrArt];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedTableRow = indexPath.row;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if([segue.identifier isEqualToString:@"segueFromVertretungsplantoDetailView"])
        {
            RaabeAppDetailViewController *controller = (RaabeAppDetailViewController *)segue.destinationViewController;
            controller.vertretung = (self.vertretungen)[_selectedTableRow];
        }
}

@end
