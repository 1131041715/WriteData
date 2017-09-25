//
//  ViewController.m
//  WriteData
//
//  Created by 大碗豆 on 17/3/8.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)NSString *folderName;
@property (nonatomic,strong)NSString *fileName;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"1234567890";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [self writeToFolderDirCache:data folder:@"12" file:@"test1"];
//    [self writeToFolderDirCache:data folder:@"12" file:@"test2"];
//    [self writeToFolderDirCache:data folder:@"12" file:@"test3"];
//    [self writeToFolderDirCache:data folder:@"12" file:@"test4"];
//    [self writeToFolderDirCache:data folder:@"12" file:@"test5"];
    
//    NSData *data1 = [self readToFolderDirCache:@"12" file:@"test1"];
//    NSLog(@"data---%@",data1);
    
//    [self deleteFolderdirCache:@"12" file:@"test1"];
    
    
//    [self writeToFileCache:data file:@"file1"];
//    NSData *data1 = [self readFileCache:@"file1"];
//    NSLog(@"data---%@",data1);
    
    
//    NSString *documentsPath =[self dirCache];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"12"];
//    
//    NSArray * dirArray = [fileManager contentsOfDirectoryAtPath:testDirectory error:nil];
//    NSString *path;
//    for (path in dirArray) {
//        NSLog(@"%@",path);
//    }
//    [self deleteFolderdirCache:@"12" file:dirArray[1]];
    
    
}


//写入Cache文件中
- (void)writeToFileCache:(NSData *)data file:(NSString *)fileName{
    NSString *documentsPath =[self dirCache];
//    NSLog(@"%@",documentsPath);
    
    NSString *FileName=[documentsPath stringByAppendingPathComponent:fileName];
    //写入文件
    [data writeToFile:FileName atomically:YES];
    
}

//读Cache中的文件
-(NSData *)readFileCache:(NSString *)fileName{
    NSString *documentsPath =[self dirCache];
    
//    NSLog(@"%@",documentsPath);
    
    NSString *FileName=[documentsPath stringByAppendingPathComponent:fileName];
    //读文件
    NSData *data=[NSData dataWithContentsOfFile:FileName options:0 error:NULL];
//    NSLog(@"data---%@",(NSString *)data1);
    return data;
}

//删除文件
-(void)deleteFiledirCache:(NSString *)fileName{
    NSString *documentsPath =[self dirCache];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    
    BOOL res=[fileManager removeItemAtPath:testDirectory error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else{
        NSLog(@"文件删除失败");
        NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:testDirectory]?@"YES":@"NO");
    }
}



//写入Cache自定义的文件夹中
- (void)writeToFolderDirCache:(NSData *)data folder:(NSString *)folderName file:(NSString *)fileName{
    //创建文件夹
    NSString *documentsPath =[self dirCache];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:folderName];
    // 创建目录
    NSError *error;
    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (res) {
        NSLog(@"文件夹创建成功");
    }else{
        NSLog(@"文件夹创建失败 --- %@",error);
    }
    
    NSString *FileName=[testDirectory stringByAppendingPathComponent:fileName];
    //写入文件
    [data writeToFile:FileName atomically:YES];
}

//读取Cache自定义的文件夹中的文件
- (NSData *)readToFolderDirCache:(NSString *)folderName file:(NSString *)fileName{
    //创建文件夹
    NSString *documentsPath =[self dirCache];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:folderName];
    NSString *FileName=[testDirectory stringByAppendingPathComponent:fileName];
    //读取文件
    NSData *data=[NSData dataWithContentsOfFile:FileName options:0 error:NULL];
//    NSLog(@"data---%@",data);
    return data;
}


//删除文件夹
-(void)deleteFolderdirCache:(NSString *)folderName file:(NSString *)fileName{
    NSString *documentsPath =[self dirCache];
    //删除文件夹 testDirectory
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:folderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //删除文件夹内的内容 testPath
    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    
    BOOL res;
    if (fileName) {
        
        res=[fileManager removeItemAtPath:testPath error:nil];
    }else{
        res=[fileManager removeItemAtPath:testDirectory error:nil];
    }
    
    if (res) {
        NSLog(@"文件删除成功");
    }else
        NSLog(@"文件删除失败");
    
    if (testPath) {
        NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
    }else{
        NSLog(@"文件夹是否存在: %@",[fileManager isExecutableFileAtPath:testDirectory]?@"YES":@"NO");
    }
}





//获取Cache目录
-(NSString *)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
    return cachePath;
}


//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
