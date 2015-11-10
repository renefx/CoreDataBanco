//
//  UIViewController+NovoBanco.m
//  CoreDataBanco
//
//  Created by Rene Xavi on 04/11/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import "NovoBancoViewController.h"
#import "UIViewController+ManagedObjectContext.h"

@import CoreData;

#import "Banco.h"

@implementation NovoBancoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)salvar:(id)sender {
    Banco * banco = [NSEntityDescription insertNewObjectForEntityForName:@"Banco" inManagedObjectContext:[self managedObjectContext]];
    if([self.nomeField.text isEqual:@""] || [self.numeroField.text isEqual:@""]){
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Digite todos os campos" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [a show];
        return;
    }
    [banco setNome:@"asdsd"];
    
    [banco setValue:self.nomeField.text forKey:@"nome"];
    [banco setValue:self.numeroField.text forKey:@"numero"];
    
    NSError * error;
    [self.managedObjectContext save:&error];
    if(error){
        NSLog(@"Error %@",error);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
