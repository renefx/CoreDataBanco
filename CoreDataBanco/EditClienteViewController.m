//
//  EditClienteViewController.m
//  CoreDataBanco
//
//  Created by Rene Xavi on 04/11/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import "EditClienteViewController.h"
#import "UIViewController+ManagedObjectContext.h"

@import CoreData;

#import "Cliente.h"
#import "Banco.h"

@implementation EditClienteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.cliente){
        self.nomeFielf.text = [self.cliente valueForKey:@"nome"];
        self.cpfField.text = [self.cliente valueForKey:@"cpf"];
    }
}

- (IBAction)atualizar:(id)sender {
    if([self.nomeFielf.text isEqual:@""] || [self.cpfField.text isEqual:@""]){
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Digite todos os campos" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [a show];
        return;
    }
    
    [self.cliente setValue:self.nomeFielf.text forKey:@"nome"];
    [self.cliente setValue:self.cpfField.text forKey:@"cpf"];
    
    NSError * error;
    [self.managedObjectContext save:&error];
    if(error){
        NSLog(@"Error %@",error);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
