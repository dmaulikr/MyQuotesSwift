//
//  FileService.h
//  backendlessAPI
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2012 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

#import <Foundation/Foundation.h>
#import "FilePermission.h"

@class BackendlessFile, Fault, NSArray, BEFileInfo;
@protocol IResponder;

@interface FileService : NSObject

@property (strong, nonatomic, readonly) FilePermission *permissions;

// sync methods with fault return (as exception)
-(BackendlessFile *)upload:(NSString *)path content:(NSData *)content;
-(BackendlessFile *)upload:(NSString *)path content:(NSData *)content overwrite:(BOOL)overwrite;
-(id)remove:(NSString *)fileURL;
-(id)removeDirectory:(NSString *)path;
-(BackendlessFile *)saveFile:(NSString *)path fileName:(NSString *)fileName content:(NSData *)content;
-(BackendlessFile *)saveFile:(NSString *)path fileName:(NSString *)fileName content:(NSData *)content overwriteIfExist:(BOOL)overwrite;
-(BackendlessFile *)saveFile:(NSString *)filePathName content:(NSData *)content;
-(BackendlessFile *)saveFile:(NSString *)filePathName content:(NSData *)content overwriteIfExist:(BOOL)overwrite;
-(NSString *)renameFile:(NSString *)oldPathName newName:(NSString *)newName;
-(NSString *)copyFile:(NSString *)sourcePathName target:(NSString *)targetPathName;
-(NSString *)moveFile:(NSString *)sourcePathName target:(NSString *)targetPathName;
// NSArray <BEFileInfo *>
-(NSArray *)listing:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive;
-(NSArray *)listing:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive pagesize:(int)pagesize offset:(int)offset;
-(NSNumber *)exists:(NSString *)path;
-(NSNumber *)getFileCount:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive countDirectories:(BOOL)countDirectories;
-(NSNumber *)getFileCount:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive;
-(NSNumber *)getFileCount:(NSString *)path pattern:(NSString *)pattern;
-(NSNumber *)getFileCount:(NSString *)path;

// async methods with responder
-(void)upload:(NSString *)path content:(NSData *)content responder:(id <IResponder>)responder;
-(void)upload:(NSString *)path content:(NSData *)content overwrite:(BOOL)overwrite responder:(id <IResponder>)responder;
-(void)remove:(NSString *)fileURL responder:(id <IResponder>)responder;
-(void)removeDirectory:(NSString *)path responder:(id <IResponder>)responder;
-(void)saveFile:(NSString *)path fileName:(NSString *)fileName content:(NSData *)content responder:(id <IResponder>)responder;
-(void)saveFile:(NSString *)path fileName:(NSString *)fileName content:(NSData *)content overwriteIfExist:(BOOL)overwrite responder:(id <IResponder>)responder;
-(void)saveFile:(NSString *)filePathName content:(NSData *)content responder:(id <IResponder>)responder;
-(void)saveFile:(NSString *)filePathName content:(NSData *)content overwriteIfExist:(BOOL)overwrite responder:(id <IResponder>)responder;
-(void)renameFile:(NSString *)oldPathName newName:(NSString *)newName responder:(id <IResponder>)responder;
-(void)copyFile:(NSString *)sourcePathName target:(NSString *)targetPathName responder:(id <IResponder>)responder;
-(void)moveFile:(NSString *)sourcePathName target:(NSString *)targetPathName responder:(id <IResponder>)responder;
-(void)listing:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive responder:(id <IResponder>)responder;
-(void)listing:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive pagesize:(int)pagesize offset:(int)offset responder:(id <IResponder>)responder;
-(void)exists:(NSString *)path responder:(id <IResponder>)responder;
-(void)getFileCount:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive countDirectories:(BOOL)countDirectories responder:(id <IResponder>)responder;
-(void)getFileCount:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive responder:(id <IResponder>)responder;
-(void)getFileCount:(NSString *)path pattern:(NSString *)pattern responder:(id <IResponder>)responder;
-(void)getFileCount:(NSString *)path responder:(id <IResponder>)responder;

// async methods with block-based callbacks
-(void)upload:(NSString *)path content:(NSData *)content response:(void(^)(BackendlessFile *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)upload:(NSString *)path content:(NSData *)content overwrite:(BOOL)overwrite response:(void(^)(BackendlessFile *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)remove:(NSString *)fileURL response:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)removeDirectory:(NSString *)path response:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)saveFile:(NSString *)path fileName:(NSString *)fileName content:(NSData *)content response:(void(^)(BackendlessFile *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)saveFile:(NSString *)path fileName:(NSString *)fileName content:(NSData *)content overwriteIfExist:(BOOL)overwrite response:(void(^)(BackendlessFile *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)saveFile:(NSString *)filePathName content:(NSData *)content response:(void(^)(BackendlessFile *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)saveFile:(NSString *)filePathName content:(NSData *)content overwriteIfExist:(BOOL)overwrite response:(void(^)(BackendlessFile *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)renameFile:(NSString *)oldPathName newName:(NSString *)newName response:(void(^)(NSString *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)copyFile:(NSString *)sourcePathName target:(NSString *)targetPathName response:(void(^)(NSString *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)moveFile:(NSString *)sourcePathName target:(NSString *)targetPathName response:(void(^)(NSString *))responseBlock error:(void(^)(Fault *))errorBlock;
// NSArray <BEFileInfo *>
-(void)listing:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive response:(void(^)(NSArray *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)listing:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive pagesize:(int)pagesize offset:(int)offset response:(void(^)(NSArray *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)exists:(NSString *)path response:(void(^)(NSNumber *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)getFileCount:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive countDirectories:(BOOL)countDirectories response:(void(^)(NSNumber *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)getFileCount:(NSString *)path pattern:(NSString *)pattern recursive:(BOOL)recursive response:(void(^)(NSNumber *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)getFileCount:(NSString *)path pattern:(NSString *)pattern response:(void(^)(NSNumber *))responseBlock error:(void(^)(Fault *))errorBlock;
-(void)getFileCount:(NSString *)path response:(void(^)(NSNumber *))responseBlock error:(void(^)(Fault *))errorBlock;

@end
