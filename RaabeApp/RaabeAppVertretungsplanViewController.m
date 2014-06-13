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

- (void)reload
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        RaabeAppVertretungsplan *vplan = [[RaabeAppVertretungsplan alloc] init];
        [vplan getVertretungsplanWithFilter:@""];
        
        _vertretungsplan = [vplan vertretungsplan];
        _sortedVertretungsplan = [vplan sortedVertretungsplan];
        _sortedVertretungsplanKeys = [vplan sortedVertretungsplanKeys];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
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
