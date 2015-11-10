//
//  UIViewController+ManagedObjectContext.m
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/24/15.
//  Copyright © 2015 Hugo Wruck Schneider. All rights reserved.
//

#import "UIViewController+ManagedObjectContext.h"
#import "AppDelegate.h"

@implementation UIViewController (ManagedObjectContext)

@dynamic managedObjectContext;

-(NSManagedObjectContext *)managedObjectContext {
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

@end
