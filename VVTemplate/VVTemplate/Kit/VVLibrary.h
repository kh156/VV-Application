//
//  VVLibrary.h
//  VVTemplate
//
//  Created by Kuang Han on 9/23/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import "VVHeader.h"

@interface VVLibrary : NSObject

@property (nonatomic, retain) NSString *StrDatabasePath;//数据库路径
@property (nonatomic, retain) NSString *StrPathMain;//主程序路径
@property (nonatomic, retain) NSString *StrPathDocument;//主程序文档路径
@property (nonatomic, retain) NSString *StrPathTemp;//临时文档路径
@property (nonatomic, retain) NSString *StrImageSuffix;//图片后缀
@property (nonatomic, retain) NSString *StrKey;//图片后缀
@property (nonatomic, readwrite)NSInteger IntScreenScale;//屏幕分辨率整型
@property (nonatomic, readwrite)CGFloat FltScreenScale;//屏幕分辨率浮点型


#pragma mark -
#pragma mark Public function

- (NSInteger)findSubviewIndexOf:(UIView *) mainView
                          byTag:(NSInteger) tag;

- (void)switchSubviewA:(NSInteger)indexA
          withSubviewB:(NSInteger)indexB
              fromView:(UIView*)mainView
           inAnimation:(NSString *)animtype
          subAnimation:(NSString *)subanimtype
          withDuration:(float)duration
              onTarget:(id)delegate;


#pragma mark -
#pragma mark File Operate

- (BOOL)checkFileExists:(NSString *)fileName
                    under:(NSString *)directory;

- (void)createFolder:(NSString *)folderName
				under:(NSString *)directory;

- (BOOL)deleteFile:(NSString *)fileName
			from:(NSString *)directory;

- (void)copyFile:(NSString *)fileName
		  from:(NSString *)initDirectory
		  to:(NSString *)targetDirectory;

- (void)saveData:(NSData*)DataT
          toFile:(NSString *)fileName
              at:(NSString *)directory;

- (void)deleteAllFilesUnder :(NSString *)directory;



#pragma mark -
#pragma mark Database Operate

//检验数据是否存在
-(BOOL)CheckDatabase :(NSString *)StrDataPath//数据库路径
				  SQL:(NSString *)StrSql;//SQL语句

//创建表、更新表中数据
-(BOOL)UpdateData :(NSString *)StrDataPath//数据库路径
			   SQL:(NSString *)StrSql;//SQL语句

//从数据库中读取一行数据，得到一维数组
-(BOOL)ReadData :(NSString *)StrDataPath//数据库路径
			 SQL:(NSString *)StrSql//SQL语句
		 ArrData:(NSMutableArray *)ArrData//保存数据到数组(一维数组)
	   IntNumber:(NSInteger) IntNumber;//列数

//从数据库中读取多行数据，得到二维数组
-(BOOL)ReadData_More :(NSString *)StrDataPath//数据库路径
				  SQL:(NSString *)StrSql//SQL语句
			  ArrData:(NSMutableArray *)ArrData //保存数据到数组(二维数组)
			IntNumber:(NSInteger) IntNumber;//列数

//--------------------------------
//以下数据库操作函数使用的数据库路径为:self.StrDatabasePath
//检验数据是否存在
- (BOOL)CheckDatabase :(NSString *)StrSql;//SQL语句

//创建表、更新表中数据
- (BOOL)UpdateData :(NSString *)StrSql;//SQL语句
//从数据库中读取一行数据，得到一维数组
- (BOOL)ReadData :(NSString *)StrSql //SQL语句
		  ArrData:(NSMutableArray *)ArrData //保存数据到数组(一维数组)
		IntNumber:(NSInteger) IntNumber;//列数
//从数据库中读取多行数据，得到二维数组
- (BOOL)ReadData_More :(NSString *)StrSql//SQL语句
			   ArrData:(NSMutableArray *)ArrData //保存数据到数组(二维数组)
			 IntNumber:(NSInteger) IntNumber;//列数
//--------------------------------
@end
