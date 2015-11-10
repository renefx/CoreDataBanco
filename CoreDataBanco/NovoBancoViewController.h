//
//  UIViewController+NovoBanco.h
//  CoreDataBanco
//
//  Created by Rene Xavi on 04/11/15.
//  Copyright (c) 2015 Hugo Wruck Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface NovoBancoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nomeField;
@property (weak, nonatomic) IBOutlet UITextField *numeroField;
@property (weak, nonatomic) IBOutlet UILabel *NomeAntgio;
@property (weak) NSManagedObject * banco;
@end