//
//  ViewController.m
//  AssignObjectDemo
//
//  Created by LiShangjing on 2023/9/2.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSObject *strongObject;
@property (nonatomic, assign) NSObject *assignObject;

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, assign) NSString *assignString;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: - NSObject Test

- (IBAction)createNSObject:(id)sender {
    _strongObject = [NSObject new];
    _assignObject = _strongObject;
    
    NSLog(@"%@",_strongObject);
    NSLog(@"%p",_strongObject);
    NSLog(@"%@",_assignObject);
    NSLog(@"%p",_assignObject);
    
    
    /**
     2023-08-15 16:26:59.247263+0800 GroceryDemo[16761:6349681] <NSObject: 0x600000604090>
     2023-08-15 16:26:59.247425+0800 GroceryDemo[16761:6349681] 0x600000604090
     2023-08-15 16:26:59.247524+0800 GroceryDemo[16761:6349681] <NSObject: 0x600000604090>
     2023-08-15 16:26:59.247622+0800 GroceryDemo[16761:6349681] 0x600000604090
     */
}

- (IBAction)destroyNSObject:(id)sender {
    _strongObject = nil;
    
    NSLog(@"%@",_strongObject);
    NSLog(@"%p",_strongObject);
    NSLog(@"%@",_assignObject); // Thread 1: EXC_BAD_ACCESS (code=1, address=0xe25411f46120)
    NSLog(@"%p",_assignObject);
    
    /**
     2023-08-15 16:27:00.213859+0800 GroceryDemo[16761:6349681] (null)
     2023-08-15 16:27:00.214020+0800 GroceryDemo[16761:6349681] 0x0
     触发野指针崩溃
     */
}

// MARK: NSString Test

- (IBAction)createNSString:(UIButton *)sender {
    // _strongString    __NSCFConstantString *    @"123"    0x00000001002000b0
    _strongString = @"123";
    
    _assignString = _strongString;
    
    NSLog(@"%@",_strongString); // 123
    NSLog(@"%p",_strongString); // 0x1002000b0
    NSLog(@"%@",_assignString); // 123
    NSLog(@"%p",_assignString); // 0x1002000b0
}

- (IBAction)createNSString2:(UIButton *)sender {
    // _strongString    NSTaggedPointerString *    @"123"    0x87e3b52b0d9069c0
    _strongString = [NSString stringWithFormat:@"123"];
    
    _assignString = _strongString;
    
    NSLog(@"%@",_strongString); // 123
    NSLog(@"%p",_strongString); // 0x87e3b52b0d9069c0
    NSLog(@"%@",_assignString); // 123
    NSLog(@"%p",_assignString); // 0x87e3b52b0d9069c0
}

- (IBAction)createNSString3:(UIButton *)sender {
    // _strongString    __NSCFString *    @"小强"    0x0000600000a7a1a0
    _strongString = [NSString stringWithFormat:@"小强"];
    
    _assignString = _strongString;
    
    NSLog(@"%@",_strongString); // 123
    NSLog(@"%p",_strongString); // 0x87e3b52b0d9069c0
    NSLog(@"%@",_assignString); // 123
    NSLog(@"%p",_assignString); // 0x87e3b52b0d9069c0
}



- (IBAction)removeNSString:(id)sender {
    _strongString = nil;
    
    NSLog(@"%@",_strongString);
    NSLog(@"%p",_strongString);
    // createNSString3
    // Thread 1: EXC_BAD_ACCESS (code=2, address=0x4955427e90)
    NSLog(@"%@",_assignString);
    NSLog(@"%p",_assignString);
    
    /**
     2023-08-15 16:38:29.190727+0800 GroceryDemo[17859:6365915] (null)
     2023-08-15 16:38:29.190844+0800 GroceryDemo[17859:6365915] 0x0
     2023-08-15 16:38:29.190910+0800 GroceryDemo[17859:6365915]
     2023-08-15 16:38:29.190970+0800 GroceryDemo[17859:6365915] 0x1097d5e90
     */
}

- (IBAction)resultNSString:(id)sender {
    NSLog(@"%@",_strongString);
    NSLog(@"%p",_strongString);
    NSLog(@"%@",_assignString);
    NSLog(@"%p",_assignString);
    
    /**
     2023-08-15 16:40:49.653496+0800 GroceryDemo[17859:6365915] (null)
     2023-08-15 16:40:49.653649+0800 GroceryDemo[17859:6365915] 0x0
     2023-08-15 16:40:49.654135+0800 GroceryDemo[17859:6365915]
     2023-08-15 16:40:49.654175+0800 GroceryDemo[17859:6365915] 0x1097d5e90
     0x600000604090
     */
}

@end
