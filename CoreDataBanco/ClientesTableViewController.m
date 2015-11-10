		//
//  ClientesTableViewController.m
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/17/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import "ClientesTableViewController.h"
#import "AppDelegate.h"
#import "UIViewController+ManagedObjectContext.h"
#import "EditClienteViewController.h"
@interface ClientesTableViewController () {
    EditClienteViewController* vc;
    NSFetchedResultsController * _fetchedResultsController;
}

@end

@implementation ClientesTableViewController

@dynamic fetchedResultsController;

-(NSFetchedResultsController *)fetchedResultsController {
    if(_fetchedResultsController){
        return _fetchedResultsController;
    }
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Cliente"];
    
    NSString *attribute = [self.banco valueForKey:@"nome"];
    NSString *attributeName = @"banco.nome";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%K BEGINSWITH[c] %@",attributeName, attribute];
    [request setPredicate:predicate];
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];

    
    
    [request setFetchBatchSize:20];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    NSError * error;
    [self.fetchedResultsController performFetch:&error];
    if(error){
        NSLog(@"%@",error);
    }
    return _fetchedResultsController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText isEqualToString:@""]){
        [[self.fetchedResultsController fetchRequest] setPredicate:[NSPredicate predicateWithFormat:
                                                                    @"banco == %@",_banco]];
    } else {
        [[self.fetchedResultsController fetchRequest] setPredicate:[NSPredicate predicateWithFormat:
                                                                    @"banco == %@ && nome contains[cd] %@",_banco,searchText]];
    }
    [[self fetchedResultsController] performFetch:nil];
    [[self tableView] reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[section];
    
    return [info numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClienteCell" forIndexPath:indexPath];

    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[indexPath.section];
    NSManagedObject * cliente =  [info objects][indexPath.row];
    
    cell.textLabel.text = [cliente valueForKey:@"nome"];
    cell.detailTextLabel.text = [cliente valueForKey:@"cpf"];
    
    return cell;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddNew"]) {
        [[segue destinationViewController] setBanco:self.banco];
    }else if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        vc = [segue destinationViewController];
        [vc setBanco:self.banco];
        
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Erro ao deletar cliente" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [a show];
            return;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[indexPath.section];
    NSManagedObject * cliente =  [info objects][indexPath.row];    
    [vc setCliente:cliente];
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"nome" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
    NSArray* searchResults = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
}



@end
