//
//  Network.h
//  IOSProgrammerTest
//
//  Created by Rahath cherukuri on 3/24/15.
//  Copyright (c) 2015 AppPartner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject

@property (strong, atomic) NSDate * startDate;

-(void)postValues: (NSString *)username withPassword: (NSString *)password;

@end
