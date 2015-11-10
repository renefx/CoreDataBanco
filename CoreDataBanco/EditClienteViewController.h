//
//  EditClienteViewController.h
//  CoreDataBanco
//
//  Created by Rene Xavi on 04/11/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface EditClienteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nomeFielf;
@property (weak, nonatomic) IBOutlet UITextField *cpfField;
@property (weak) NSManagedObject * cliente;
@property (weak) NSManagedObject * banco;
@end
