//
//  NovoClienteViewController.m
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/24/15.
//  Copyright © 2015 Hugo Wruck Schneider. All rights reserved.
//

#import "NovoClienteViewController.h"
#import "UIViewController+ManagedObjectContext.h"

@import CoreData;

#import "Cliente.h"
#import "Banco.h"

@implementation NovoClienteViewController
- (IBAction)salvar:(id)sender {
    if([self.nomeFielf.text isEqual:@""] || [self.cpfField.text isEqual:@""]){
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Digite todos os campos" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [a show];
        return;
    }
    
    Cliente * cliente = [NSEntityDescription insertNewObjectForEntityForName:@"Cliente" inManagedObjectContext:[self managedObjectContext]];
    
    [cliente setValue:self.nomeFielf.text forKey:@"nome"];
    [cliente setValue:self.cpfField.text forKey:@"cpf"];
    [cliente setValue:self.banco forKey:@"banco"];

    NSError * error;
    [self.managedObjectContext save:&error];
    if(error){
        NSLog(@"Error %@",error);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
