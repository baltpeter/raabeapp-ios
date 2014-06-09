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
    vtrArtImg.image = [[RaabeAppGenericTableViewController alloc] imageForVtrArt:[[vertretung objectForKey:@"vtr_art"] objectForKey:@"color"]];
    
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
        controller.vertretung = [[self.vertretungsplan objectForKey:@"data"] objectAtIndex:_selectedTableRow];
    }
}

- (void)reload
{
    _errorLabel.text = @"";
    RaabeAppVertretungsplan *vplan = [[RaabeAppVertretungsplan alloc] init];
    [vplan getVertretungsplanWithFilter:(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"filter"]];
    
    _vertretungsplan = [vplan vertretungsplan];
    
    _informationenLabel.text = [[self.vertretungsplan objectForKey:@"info_data"] stringByReplacingOccurrencesOfString: @"\\n" withString: @"\n"];
    [_homeTableView reloadData];
    
    if([[self.vertretungsplan objectForKey:@"data"] count] > 0) {
        _datumLabel.text = [[[self.vertretungsplan objectForKey:@"data"] objectAtIndex:0] objectForKey:@"datum"];
    }
    else {
        _datumLabel.text = @"";
        if(![(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"filter"] isEqual: @""]) {
            _errorLabel.text = [NSString stringWithFormat:@"Keine Vertretungen für \"%@\".", (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"filter"]];
        }
        else {
            _errorLabel.text = @"Keine Vertretungen.";
        }
        
    }
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
