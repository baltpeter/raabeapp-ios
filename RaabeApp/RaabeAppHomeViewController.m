//
//  RaabeAppHomeViewController.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 08.06.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppHomeViewController.h"

@implementation RaabeAppHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    vtrArtImg.image = [[RaabeAppGenericTableViewController alloc] imageForVtrArt:[[vertretung objectForKey:@"vtr_art"] objectForKey:@"color"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedTableRow = indexPath.row;
    _selectedTableSection = indexPath.section;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueFromHomeToDetailView"])
    {
        RaabeAppDetailViewController *controller = (RaabeAppDetailViewController *)segue.destinationViewController;
        controller.vertretung = [[_sortedVertretungsplan objectForKey:[_sortedVertretungsplanKeys objectAtIndex:_selectedTableSection]] objectAtIndex:_selectedTableRow];
    }
}

- (void)receiveNewVertretungsplan:(RaabeAppVertretungsplan *)vertretungsplan {
    _vertretungsplan = [vertretungsplan vertretungsplan];
    _sortedVertretungsplan = [vertretungsplan sortedVertretungsplan];
    _sortedVertretungsplanKeys = [vertretungsplan sortedVertretungsplanKeys];
    [self reloadGui];
}

- (void)reload
{
    _errorLabel.text = @"";
    RaabeAppVertretungsplan *vplan = [[RaabeAppVertretungsplan alloc] init];
    [vplan getVertretungsplanWithFilter:(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_filter"] AndInformDelegate:self];
}

- (void) reloadGui
{
    NSString *informationenText = [[self.vertretungsplan objectForKey:@"info_data"] stringByReplacingOccurrencesOfString: @";;" withString: @"\n"];
    _informationenLabel.text = [self stringByStrippingHTML:informationenText];
    [_homeTableView reloadData];
    
    if([[self.vertretungsplan objectForKey:@"data"] count] > 0) {
        _datumLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Substitutions %@", nil), [self.vertretungsplan objectForKey:@"date"]];
    }
    else {
        _datumLabel.text = @"";
        if([(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_filter"] isEqual: @""] || [(NSString *)[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_filter"] == nil) {
            _errorLabel.text = NSLocalizedString(@"No substitutions.", nil);
        }
        else {
            _errorLabel.text = [NSString stringWithFormat:NSLocalizedString(@"No substitutions for \"%@\" on %@.", nil), (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_filter"], [self.vertretungsplan objectForKey:@"date"]];
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

// respond to the user clicking "Open Settings.app" when a wrong password is entered
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([alertView tag] == 401) {    // it's the pw error alert
        if(buttonIndex == 1) {      // and they clicked "Open Settings.app".
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

// see http://stackoverflow.com/a/4886998/3211062
- (NSString *)stringByStrippingHTML:(NSString *)string {
    NSRange r;
    if(!string) {
        string = @"";
    }
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    }
    return string;
}

@end
