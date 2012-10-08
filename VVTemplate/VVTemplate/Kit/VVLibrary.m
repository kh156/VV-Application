//
//  VVLibrary.m
//  VVTemplate
//
//  Created by Kuang Han on 9/23/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import "VVLibrary.h"

@implementation VVLibrary

@synthesize StrPathMain,StrPathDocument,StrPathTemp,StrDatabasePath,FltScreenScale,IntScreenScale,StrImageSuffix,StrKey;


#pragma mark -
#pragma mark init
//init Data
-(id) init{
	if( self=[super init] )
	{
		NSArray *ArrPath;
		self.StrPathMain=[[NSBundle mainBundle]resourcePath];
		ArrPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		self.StrPathDocument=[ArrPath objectAtIndex:0];
		self.StrPathTemp=NSTemporaryDirectory();
		self.IntScreenScale=1;
		self.FltScreenScale=1.0;
		self.StrImageSuffix=@"";
		self.StrDatabasePath=@"";
	}
	return self;
}

#pragma mark -
#pragma mark Public function

- (NSInteger)findSubviewIndexOf:(UIView *)mainView
                          byTag:(NSInteger)tag {
	for (NSInteger i=0; i<[mainView.subviews count]; i++){
		if (((UIView*)[mainView.subviews objectAtIndex:i]).tag == tag) {
			return i;
		}
	}
	return -1;
}

/*
 SubAnimationtype:
    kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 Animationtype:
    kCATransitionFade
    kCATransitionMoveIn
    kCATransitionPush
    kCATransitionReveal
    @"cameraIris"
    @"cameraIrisHollowOpen"
    @"cameraIrisHollowClose"
    @"cube"
    @"alignedCube"
    @"flip"
    @"alignedFlip"
    @"oglFlip"
    @"rotate"
    @"pageCurl"
    @"pageUnCurl"
    @"rippleEffect"
    @"suckEffect"
 */
- (void)switchSubviewA:(NSInteger)indexA
          withSubviewB:(NSInteger)indexB
              fromView:(UIView*)mainView
           inAnimation:(NSString *)animtype
          subAnimation:(NSString *)subanimtype
          withDuration:(float)duration
              onTarget:(id)delegate {
	CATransition *anim = [CATransition animation];
	[anim setDuration:duration];
	[anim setFillMode: kCAFillModeForwards];
	[anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	if (subanimtype != nil && ![subanimtype isEqualToString:@""]) {
		[anim setSubtype:subanimtype];
	}
	
	if (![animtype isEqualToString:@""]) {
		[anim setType:animtype];
	}
	anim.delegate = delegate;
	[mainView exchangeSubviewAtIndex:indexA withSubviewAtIndex:indexB];
	[mainView.layer addAnimation:anim forKey:nil];
}


#pragma mark -
#pragma mark File Operate

- (BOOL)checkFileExists:(NSString *)fileName
                  under:(NSString *)directory {
	NSFileManager *FmTemp=[NSFileManager defaultManager];
	return [FmTemp fileExistsAtPath:[directory stringByAppendingPathComponent:fileName]]   ;
}


- (void)createFolder:(NSString *)folderName
               under:(NSString *)directory {
	BOOL IsExists=[self checkFileExists:folderName under:directory];
	if (!IsExists) {
		NSFileManager *FmTemp=[NSFileManager defaultManager];
		[FmTemp createDirectoryAtPath:[directory stringByAppendingPathComponent:folderName]
		  withIntermediateDirectories:YES
						   attributes:nil
								error:NULL];
	}
}

- (BOOL)deleteFile:(NSString *)fileName
			from:(NSString *)directory {
	NSFileManager *FmTemp=[NSFileManager defaultManager];
	BOOL IsExists= [FmTemp fileExistsAtPath:[directory stringByAppendingPathComponent:fileName]];
	if (IsExists) {
		[FmTemp removeItemAtPath:[directory stringByAppendingPathComponent:fileName] error:nil];
	}
	
	return IsExists;
}

- (void)copyFile:(NSString *)fileName
		  from:(NSString *)initDirectory
		  to:(NSString *)targetDirectory {
	NSFileManager *FmTemp=[NSFileManager defaultManager];
	BOOL IsExists=[FmTemp fileExistsAtPath:[targetDirectory stringByAppendingPathComponent:fileName]];
	if (!IsExists) {
		[FmTemp copyItemAtPath:[initDirectory stringByAppendingPathComponent:fileName] toPath:[targetDirectory stringByAppendingPathComponent:fileName] error:nil];
	}
}

- (void)saveData:(NSData*)DataT
          toFile:(NSString *)fileName
              at:(NSString *)directory{
	[self deleteFile:fileName from:directory];
	[DataT writeToFile:[directory stringByAppendingPathComponent:fileName] atomically:NO];
}

- (void)deleteAllFilesUnder :(NSString *)directory{
	NSFileManager *FmTemp=[NSFileManager defaultManager];
	NSInteger IntI;
	// look for files
	NSArray *ArrA = [FmTemp subpathsOfDirectoryAtPath:directory error:nil];
	if (ArrA!=nil) {
		for(IntI=0;IntI<[ArrA count];IntI++){
			[FmTemp removeItemAtPath:[directory stringByAppendingPathComponent:[ArrA objectAtIndex:IntI-1]]
							   error:nil];
		}
	}
}



#pragma mark -
#pragma mark Database Operate

//检验数据是否存在
-(BOOL)CheckDatabase :(NSString *)StrDataPath//数据库路径
				  SQL:(NSString *)StrSql{//SQL语句
	
	sqlite3_stmt *SkMySt;
	sqlite3 *SkMyDb;
	BOOL IsExists;
	IsExists=NO;
	//打开数据训
	if(sqlite3_open([StrDataPath UTF8String], &SkMyDb) != SQLITE_OK) {
		sqlite3_close(SkMyDb);
	}
	else
	{	//读取一行数据
		sqlite3_prepare_v2(SkMyDb,[StrSql UTF8String],-1,&SkMySt,nil);
		//读取成功
		if (sqlite3_step(SkMySt)==SQLITE_ROW) {
			IsExists=YES;
		}
		sqlite3_finalize(SkMySt);
		sqlite3_close(SkMyDb);
	}
	return IsExists;
}

//创建表、更新表中数据
-(BOOL)UpdateData :(NSString *)StrDataPath//数据库路径
			   SQL:(NSString *)StrSql{//SQL语句
	
	BOOL IsSuccess;
	sqlite3 *SkMyDb;
	IsSuccess=NO;
	NSInteger IntR;
	if(sqlite3_open([StrDataPath UTF8String], &SkMyDb) != SQLITE_OK) {
		sqlite3_close(SkMyDb);
	}
	else
	{
		IntR=sqlite3_exec(SkMyDb, [StrSql UTF8String], 0, 0, nil);
		sqlite3_close(SkMyDb);
		
		if (IntR!=SQLITE_OK){
			IsSuccess=NO;
		}
		else {
			IsSuccess=YES;
		}
        
	}
	
	return IsSuccess;
}

//从数据库中读取一行数据，得到一维数组
-(BOOL)ReadData :(NSString *)StrDataPath//数据库路径
			 SQL:(NSString *)StrSql//SQL语句
		 ArrData:(NSMutableArray *)ArrData//保存数据到数组(一维数组)
	   IntNumber:(NSInteger) IntNumber{//列数
	
	NSInteger IntI;
	sqlite3_stmt *SkMySt;
	sqlite3 *SkMyDb;
	BOOL IsSuccess;
	IsSuccess=NO;
	if (ArrData!=nil) {
		if(sqlite3_open([StrDataPath UTF8String], &SkMyDb) != SQLITE_OK) {
			sqlite3_close(SkMyDb);
		}
		else
		{
			sqlite3_prepare_v2(SkMyDb,[StrSql UTF8String],-1,&SkMySt,nil);
			if (sqlite3_step(SkMySt)==SQLITE_ROW) {
				for (IntI=1; IntI<=IntNumber; IntI++){
					IsSuccess=YES;
					[ArrData addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(SkMySt,IntI-1)]];
				}
			}
			sqlite3_finalize(SkMySt);
			sqlite3_close(SkMyDb);
		}
	}
	
	return IsSuccess;
}

//从数据库中读取多行数据，得到二维数组
-(BOOL)ReadData_More :(NSString *)StrDataPath//数据库路径
				  SQL:(NSString *)StrSql//SQL语句
			  ArrData:(NSMutableArray *)ArrData //保存数据到数组(二维数组)
			IntNumber:(NSInteger) IntNumber{//列数
	
	NSInteger IntI;
	sqlite3_stmt *SkMySt;
	sqlite3 *SkMyDb;
	NSMutableArray *ArrA;
	BOOL IsSuccess;
	IsSuccess=NO;
	if (ArrData!=nil) {
		if(sqlite3_open([StrDataPath UTF8String], &SkMyDb) != SQLITE_OK) {
			sqlite3_close(SkMyDb);
		}
		else
		{
			sqlite3_prepare_v2(SkMyDb,[StrSql UTF8String],-1,&SkMySt,nil);
			while (sqlite3_step(SkMySt)==SQLITE_ROW) {
				ArrA=[[NSMutableArray alloc] init];
				for (IntI=1; IntI<=IntNumber; IntI++) {
					IsSuccess=YES;
					[ArrA addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(SkMySt,IntI-1)]];
				}
				[ArrData addObject:ArrA];
			}
			sqlite3_finalize(SkMySt);
			sqlite3_close(SkMyDb);
			
		}
	}
	return IsSuccess;
	
}

//--------------------------------
//以下数据库操作函数使用的数据库路径为:self.StrDatabasePath
//检验数据是否存在
- (BOOL)CheckDatabase :(NSString *)StrSql{//SQL语句
	return [self CheckDatabase:self.StrDatabasePath
						   SQL:StrSql];
}

//创建表、更新表中数据
- (BOOL)UpdateData :(NSString *)StrSql{//SQL语句
	return [self UpdateData:self.StrDatabasePath SQL:StrSql];
}
//从数据库中读取一行数据，得到一维数组
- (BOOL)ReadData :(NSString *)StrSql //SQL语句
		  ArrData:(NSMutableArray *)ArrData //保存数据到数组(一维数组)
		IntNumber:(NSInteger) IntNumber{//列数
	return [self ReadData:self.StrDatabasePath
					  SQL:StrSql
				  ArrData:ArrData
				IntNumber:IntNumber];
}
//从数据库中读取多行数据，得到二维数组
- (BOOL)ReadData_More :(NSString *)StrSql//SQL语句
			   ArrData:(NSMutableArray *)ArrData //保存数据到数组(二维数组)
			 IntNumber:(NSInteger) IntNumber{//列数
	
	return [self ReadData_More:self.StrDatabasePath
						   SQL:StrSql
					   ArrData:ArrData
					 IntNumber:IntNumber];
}
//--------------------------------
@end
