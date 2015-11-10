//
//  Cliente+CoreDataProperties.h
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/24/15.
//  Copyright © 2015 Hugo Wruck Schneider. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Cliente.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cliente (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nome;
@property (nullable, nonatomic, retain) NSString *cpf;
@property (nullable, nonatomic, retain) NSManagedObject *banco;

@end

NS_ASSUME_NONNULL_END
