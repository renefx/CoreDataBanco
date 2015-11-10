//
//  ViewController.h
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/17/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreData;

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nomeBancoSearch;
@property (weak, nonatomic) IBOutlet UITextField *nomeClienteSearch;
@property (weak, nonatomic) IBOutlet UITextField *qtClientesSearch;
@property (readonly) NSFetchedResultsController * fetchedResultsController;

@end

