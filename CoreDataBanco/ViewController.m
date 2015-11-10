//
//  ViewController.m
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/17/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ClientesTableViewController.h"
#import "UIViewController+ManagedObjectContext.h"

@import CoreData;

@interface ViewController (){
    ClientesTableViewController * vc;
    NSFetchedResultsController * _fetchedResultsController;
}
@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numeroLabel;
@property (strong) NSManagedObject * banco;
@end

@implementation ViewController

@dynamic fetchedResultsController;

-(NSFetchedResultsController *)fetchedResultsController {
    if(_fetchedResultsController){
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Banco"];
    NSPredicate * predicate;
    
    NSString *attributoNomeBanco = @"nome";
    NSString *attributoNomeCliente = @"clientes.nome";
    
    NSString *nomeClienteValor = self.nomeClienteSearch.text;
    NSString *nomeBancoValor = self.nomeBancoSearch.text;
    NSString *qtClienteString = self.qtClientesSearch.text;
    NSNumber *qtCliente = [NSNumber numberWithInteger: [qtClienteString integerValue]];

    if([qtClienteString isEqual:@""]){
        if([nomeBancoValor isEqual:@""]){
            if([nomeClienteValor isEqual:@""]){
                //tudo vazio
            }else{
                //so nome cliente
                predicate = [NSPredicate predicateWithFormat: @"ANY %K BEGINSWITH[c] %@",attributoNomeCliente, nomeClienteValor];
            }
        }else{
            if([self.nomeClienteSearch.text isEqual:@""]){
                //so nome banco
                predicate = [NSPredicate predicateWithFormat: @"%K BEGINSWITH[c] %@",attributoNomeBanco, nomeBancoValor];
            }else{
                //nome banco e nome cliente
                predicate = [NSPredicate predicateWithFormat: @"%K BEGINSWITH[c] %@ AND ANY %K BEGINSWITH[c] %@",attributoNomeBanco, nomeBancoValor,attributoNomeCliente, nomeClienteValor];
            }
        }
    }else{
        if([nomeBancoValor isEqual:@""]){
            if([nomeClienteValor isEqual:@""]){
                //so qtd cliente
                predicate = [NSPredicate predicateWithFormat: @"clientes.@count >= %@", qtCliente];
            }else{
                //qtd cliente e nome cliente
                predicate = [NSPredicate predicateWithFormat: @"(clientes.@count >= %@) AND (ANY %K BEGINSWITH[c] %@)", qtCliente, attributoNomeCliente, nomeClienteValor];
            }
        }else{
            if([self.nomeClienteSearch.text isEqual:@""]){
                //qtd cliente e nome banco
                predicate = [NSPredicate predicateWithFormat: @"(clientes.@count >= %@) AND (%K BEGINSWITH[c] %@)", qtCliente, attributoNomeBanco, nomeBancoValor];
            }else{
                //tudo
                predicate = [NSPredicate predicateWithFormat: @"(clientes.@count >= %@) OR (%K BEGINSWITH[c] %@ AND ANY %K BEGINSWITH[c] %@)", qtCliente,attributoNomeBanco, nomeBancoValor,attributoNomeCliente, attributoNomeCliente];
                
            }
        }
    }
    
    [request setPredicate:predicate];
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES]]];
    
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
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Banco"];
    
    NSArray * bancos = [self.managedObjectContext executeFetchRequest:request error:nil];
    if([bancos count]){
        NSManagedObject * banco = [bancos firstObject];
        [_nomeLabel setText:[banco valueForKey:@"nome"]];
        [_numeroLabel setText:[banco valueForKey:@"numero"]];
        [self setBanco:banco];
                NSLog(@"%@", banco);
    }
   
}

- (IBAction)salvar:(id)sender {
    _fetchedResultsController=nil;
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    vc = [segue destinationViewController];
    [vc setBanco:self.banco];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[section];
    
    return [info numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[indexPath.section];
    NSManagedObject * banco =  [info objects][indexPath.row];
    [vc setBanco:banco];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BancoCell" forIndexPath:indexPath];
    
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[indexPath.section];
    NSManagedObject * banco =  [info objects][indexPath.row];
    
    cell.textLabel.text = [banco valueForKey:@"nome"];
    cell.detailTextLabel.text = [banco valueForKey:@"numero"];
    // Configure the cell...
    
    return cell;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
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

@end
