//
//  Banco.h
//  CoreDataBanco
//
//  Created by Rene Xavi on 04/11/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cliente;

@interface Banco : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * numero;
@property (nonatomic, retain) NSSet *clientes;
@end

@interface Banco (CoreDataGeneratedAccessors)

- (void)addClientesObject:(Cliente *)value;
- (void)removeClientesObject:(Cliente *)value;
- (void)addClientes:(NSSet *)values;
- (void)removeClientes:(NSSet *)values;

@end
