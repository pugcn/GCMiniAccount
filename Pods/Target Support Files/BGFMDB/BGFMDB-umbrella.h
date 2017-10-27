#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BGFMDB.h"
#import "BGFMDBConfig.h"
#import "BGModelInfo.h"
#import "BGTool.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "FMDB.h"
#import "FMResultSet.h"
#import "NSObject+BGModel.h"

FOUNDATION_EXPORT double BGFMDBVersionNumber;
FOUNDATION_EXPORT const unsigned char BGFMDBVersionString[];

