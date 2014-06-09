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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.vertretungsplan objectForKey:@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RaabeAppVertretungCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VertretungCell"];
    
    NSDictionary *vertretung = [[self.vertretungsplan objectForKey:@"data"] objectAtIndex:indexPath.row];
    
    cell.klasseLabel.text = [vertretung objectForKey:@"klassen"];
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
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if([segue.identifier isEqualToString:@"segueFromVertretungsplanToDetailView"])
        {
            RaabeAppDetailViewController *controller = (RaabeAppDetailViewController *)segue.destinationViewController;
            controller.vertretung = [[self.vertretungsplan objectForKey:@"data"] objectAtIndex:_selectedTableRow];
        }
}

- (void)reload
{
    RaabeAppVertretungsplan *vplan = [[RaabeAppVertretungsplan alloc] init];
    [vplan getVertretungsplanWithFilter:@""];
    
    _vertretungsplan = [vplan vertretungsplan];
    
    [self.tableView reloadData];
}

- (IBAction)reloadButtonPressed:(id)sender {
    [self reload];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reload];
}

@end
