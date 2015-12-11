//
//  ViewController.m
//  FileRead&WriteDemo
//
//  Created by zhanglei on 15/12/11.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSData * data;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"读取" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 160, 100, 40)];
    [btn1 setTitle:@"写入" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 40)];
    [btn2 setTitle:@"加载" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(load:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn2];
}

-(void)read:(id)sender{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [[path stringByAppendingPathComponent:@"aaa"] stringByAppendingPathExtension:@"txt"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"未找到相应文件，请查看是否存在该文件或者该文件是否写入成功！");
    }
    NSData * data1 = [NSData dataWithContentsOfFile:filePath];
    NSString * string=  [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];
    NSLog(@"文件内容为:%@",string);
}

-(void)write:(id)sender{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path1 = [path stringByAppendingPathComponent:@"aaa"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path1]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * filePath = [[path1 stringByAppendingPathComponent:@"bbb"]  stringByAppendingPathExtension:@"txt"];
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    BOOL success =[[string dataUsingEncoding:NSUTF8StringEncoding] writeToFile:filePath atomically:YES];
    if (success) {
        NSLog(@"写入成功");
    }else{
        NSLog(@"写入失败");
    }
}

-(void)load:(id)sender{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"aaa" ofType:@"txt"];
    NSLog(@"path:%@",path);
    data = [NSData dataWithContentsOfFile:path];
    NSLog(@"data:%@",data);
    NSLog(@"content:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
