//
//  ViewController.m
//  Project12
//
//  Created by BSA Univ4 on 30/01/14.
//  Copyright (c) 2014 BSA Univ4. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSManagedObjectContext *context;
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self FoodTextField]setDelegate:self];
    [[self EntertainmentTextField]setDelegate:self];
    [[self HealthcareTextField]setDelegate:self];
    
    AppDelegate *appdelegate= [[UIApplication sharedApplication]delegate];
    context =[appdelegate managedObjectContext];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SaveButton:(id)sender
{
    NSEntityDescription *entitydesc =[NSEntityDescription entityForName:@"Product" inManagedObjectContext:context];
    NSManagedObject *newProduct=[[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    [newProduct setValue:self.FoodTextField.text forKey:@"food"];
    [newProduct setValue:self.EntertainmentTextField.text forKey:@"entertainment"];
    [newProduct setValue:self.HealthcareTextField.text forKey:@"heathcare"];
    
    NSError *error;
    [context save:&error];
    self.LabelView.text =@"Product added";

}

- (IBAction)DisplayButton:(id)sender
{
    
        NSEntityDescription *entitydesc =[NSEntityDescription entityForName:@"Product" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        [request setEntity:entitydesc];
       NSPredicate *predicate = [NSPredicate predicateWithFormat:@"food like %@ and entertainment like %@ and healthcare like %@",self.FoodTextField.text,self.EntertainmentTextField.text,self.HealthcareTextField.text];
       [request setPredicate:predicate];
        NSError *error;
        NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
        if(matchingData.count <= 0)
        {
            self.LabelView.text=@"No Product Found";
        }
        else
        {
        NSString *food;
        NSString *entertainment;
        NSString *healthcare;
        for(NSManagedObject *obj in matchingData)
        {
            food = [obj valueForKey:@"food"];
            entertainment = [obj valueForKey:@"entertainment"];
            healthcare = [obj valueForKey:@"healthcare"];
    
        }
        self.LabelView.text =[NSString stringWithFormat:@"food %@,entertainment %@,healthcare %@",food,entertainment,healthcare];
        }

}
@end
