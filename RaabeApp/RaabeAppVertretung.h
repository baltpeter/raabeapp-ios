//
//  RaabeAppVertretung.h
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RaabeAppVertretung : NSObject

@property (nonatomic, copy) NSString *datum;
@property (nonatomic, copy) NSString *stunde;
@property (nonatomic, copy) NSString *absenterLehrer;
@property (nonatomic, copy) NSString *vtrLehrer;
@property (nonatomic, copy) NSString *fach;
@property (nonatomic, copy) NSString *vtrFach;
@property (nonatomic, copy) NSString *vtrRaum;
@property (nonatomic, copy) NSString *klassen;
@property (nonatomic, copy) NSString *vtrText;
@property (nonatomic, copy) NSString *vtrArt;
@property (nonatomic, copy) NSString *le_nach;

- (NSDictionary *) dictDescriptionToValue;

@end
