//
//  NovoClienteViewController.h
//  CoreDataBanco
//
//  Created by Hugo Wruck Schneider on 9/24/15.
//  Copyright © 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface NovoClienteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nomeFielf;
@property (weak, nonatomic) IBOutlet UITextField *cpfField;
@property (weak) NSManagedObject * banco;
@end
