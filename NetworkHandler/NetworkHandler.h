//
//  NetworkHandler.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#define MAX_TIME_TO_WAIT_FOR_IMAGE 120.0 

typedef enum{
    RequestTypeGET =1,
    RequestTypePOST,
    RequestTypePUT,
    RequestTypeDelete,
}RequestType;

@interface NetworkHandler : NSObject

+(void)cancelAllRequest;

+(void)checkReachabilityWithSuccess:(void(^)())success andFailed:(void(^)())failed;

+(void)requestWithUrl:(NSString *)url andRequestParameter:(id)parameter andRequestType:(RequestType)requestType andRequiredAuthorization:(BOOL)requiredAuthorization andTag:(NSString *)tag andCompletetion:(void (^)(BOOL status,id responseObj, NSString *tag, NSError *error , NSInteger statusCode))completion;

+(void)responseWithUrl:(NSString *)url andPostResponse:(NSDictionary *)parameters andImageData:(NSData *)imageData andIsImageChanged:(BOOL)isImageChanged andRequestType:(RequestType)requestType andRequiredAuthorization:(BOOL)requiredAuthorization andImageKey:(NSString *)imageKey andCompletetion:(void (^)(BOOL status,id responseObj, NSString *tag, NSError *error , NSInteger statusCode))completion;

@end
