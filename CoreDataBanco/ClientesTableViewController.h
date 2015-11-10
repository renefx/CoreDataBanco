//
//  ClientesTableViewController.h
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/17/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreData;

@interface ClientesTableViewController : UITableViewController<UISearchBarDelegate, NSFetchedResultsControllerDelegate>

@property (readonly) NSFetchedResultsController * fetchedResultsController;

@property (weak) NSManagedObject * banco;

@end
