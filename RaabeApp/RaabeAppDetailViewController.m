//
//  RaabeAppDetailViewController.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 06.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppDetailViewController.h"

@implementation RaabeAppDetailViewController

//- (void) viewDidLoad
//{
//    [super viewDidLoad];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_vertretung dictDescriptionToValue].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RaabeAppVertretungCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VertretungCell"];
//    
//    RaabeAppVertretung *vertretung = (self.vertretungen)[indexPath.row];
//    
//    cell.klasseLabel.text = vertretung.klasse;
//    cell.stundeLabel.text = vertretung.stunde;
//    cell.vtrLehrerLabel.text = vertretung.vtrLehrer;
//    cell.absenterLehrerLabel.text = vertretung.absenterLehrer;
//    cell.vtrRaumLabel.text = vertretung.vtrRaum;
//    cell.vtrFachLabel.text = vertretung.vtrFach;
//    
//    if(indexPath.section == 0)
//    {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VtrArtCell"];
//    
//        UILabel *vtrArtLabel = (UILabel *)[cell viewWithTag:101];
//        vtrArtLabel.text = _vertretung.vtrArt;
//    
//        UILabel *klasseLabel = (UILabel *)[cell viewWithTag:102];
//        klasseLabel.text = _vertretung.klasse;
//    
//        UIImageView *vtrArtImg = (UIImageView *)[cell viewWithTag:100];
//        vtrArtImg.image = [self imageForVtrArt:_vertretung.vtrArt];
//
//        return cell;
//    }
//    else if (indexPath.section == 1)
//    {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailInfoCell"];
        
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:100];
    descriptionLabel.text = [_vertretung dictDescriptionToValue].allKeys[_currentRow];

    _currentRow++;
  
    return cell;

}

@end
