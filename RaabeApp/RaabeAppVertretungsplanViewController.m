//
//  RaabeAppVertretungsplanViewController.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppVertretungsplanViewController.h"
#import "RaabeAppVertretungCell.h"

@implementation RaabeAppVertretungsplanViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sortedVertretungsplanKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_sortedVertretungsplan objectForKey:[_sortedVertretungsplanKeys objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sortedVertretungsplanKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RaabeAppVertretungCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VertretungCell"];
    
    NSDictionary *vertretung = [[_sortedVertretungsplan objectForKey:[_sortedVertretungsplanKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    cell.stundeLabel.text = [vertretung objectForKey:@"stunde"];
    cell.vtrLehrerLabel.text = [vertretung objectForKey:@"vtr_lehrer"];
    cell.absenterLehrerLabel.text = [vertretung objectForKey:@"absenter_lehrer"];
    cell.vtrRaumLabel.text = [vertretung objectForKey:@"vtr_raum"];
    cell.vtrFachLabel.text = [vertretung objectForKey:@"fach"];
    
    UIImageView *vtrArtImg = (UIImageView *)[cell viewWithTag:101];
    vtrArtImg.image = [self imageForVtrArt:[[vertretung objectForKey:@"vtr_art"] objectForKey:@"color"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedTableRow = indexPath.row;
    _selectedTableSection = indexPath.section;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueFromVertretungsplanToDetailView"])
    {
        RaabeAppDetailViewController *controller = (RaabeAppDetailViewController *)segue.destinationViewController;
        controller.vertretung = [[_sortedVertretungsplan objectForKey:[_sortedVertretungsplanKeys objectAtIndex:_selectedTableSection]] objectAtIndex:_selectedTableRow];
    }
}

- (void)receiveNewVertretungsplan:(RaabeAppVertretungsplan *)vertretungsplan {
    _vertretungsplan = [vertretungsplan vertretungsplan];
    _sortedVertretungsplan = [vertretungsplan sortedVertretungsplan];
    _sortedVertretungsplanKeys = [vertretungsplan sortedVertretungsplanKeys];
    [self.tableView reloadData];
}

- (void)reload
{
    
    RaabeAppVertretungsplan *vplan = [[RaabeAppVertretungsplan alloc] init];
    [vplan getVertretungsplanWithFilter:@"" AndInformDelegate:self];
}

// respond to the user clicking "Open Settings.app" when a wrong password is entered
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([alertView tag] == 401) {    // it's the pw error alert
        if(buttonIndex == 1) {      // and they clicked "Open Settings.app".
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

- (IBAction)reloadButtonPressed:(id)sender
{
    [self reload];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reload];
}

@end
