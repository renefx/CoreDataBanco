//
//  Cliente.h
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/24/15.
//  Copyright © 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cliente : NSManagedObject

-(void) validarCliente;

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Cliente+CoreDataProperties.h"
