//
//  UIViewController+ManagedObjectContext.h
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/24/15.
//  Copyright © 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface UIViewController (ManagedObjectContext)

@property (readonly) NSManagedObjectContext * managedObjectContext;

@end
