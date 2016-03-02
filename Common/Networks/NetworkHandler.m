//
//  NetworkHandler.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//
#import "NetworkHandler.h"

NSString * const akAPIBaseURL = @"http://54.201.32.5/pronto/public/api";
NSString * const akAPIKey = @"secret123";
NSString * const akRequestAcceptsType = @"application/json";
NSString * const akRequestContentType = @"application/json";
NSString * const akAutherizationToken = @"";

NSString * const NetworkReachablityUpdate = @"NetworkReachablityUpdate";

 
@implementation NetworkHandler

+(NetworkHandler *)networkHandler{
    static NetworkHandler *networkHandler = nil;
    if (!networkHandler) {
        networkHandler = [[NetworkHandler alloc] init];
        [self checkReachabilityWithSuccess:^{
            networkHandler.isReachable = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:NetworkReachablityUpdate object:[NSNumber numberWithBool:YES]];
        } andFailed:^{
            networkHandler.isReachable = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:NetworkReachablityUpdate object:[NSNumber numberWithBool:NO]];
        }];
    }
    return networkHandler;
}

+(void)showNetworkErrorAlertWithError:(NSError *)error{
    if ([NetworkHandler networkHandler].showNetworkErrorMessage) {
        [[[UIAlertView alloc] initWithTitle:@"Network Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

+(void)cancelAllRequest{
    [[[AFHTTPRequestOperationManager manager] operationQueue] cancelAllOperations];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    DebugLog(@"All Request Suspended!!");
}

+(void)checkReachabilityWithSuccess:(void(^)())success andFailed:(void(^)())failed{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusNotReachable){
            if (failed) failed();
        }
        else{
            if (success) success();
        }
    }];
}

+(void)requestWithUrl:(NSString *)url andRequestParameter:(id)parameter andRequestType:(RequestType)requestType andRequiredAuthorization:(BOOL)requiredAuthorization andTag:(NSString *)tag andCompletetion:(void (^)(BOOL status,id responseObj, NSString *tag, NSError *error , NSInteger statusCode))completion{
    @try {
        DebugLog(@"Request Parameter \n######################\n\n%@\n\n######################\n",parameter);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
        requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [requestManager.requestSerializer setValue:akAPIKey forHTTPHeaderField:@"ApiKey"];
        [requestManager.requestSerializer setValue:akRequestAcceptsType forHTTPHeaderField:@"Accepts"];
        if(requiredAuthorization) [requestManager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] authTokenForServerRequest] forHTTPHeaderField:@"fld-oauth-token"];
        
        NSString *urlString = [url containsString:akAPIBaseURL]?url:[NSString stringWithFormat:@"%@%@",akAPIBaseURL,url];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        DebugLog(@"Request URL\n######################\n\n%@\n\n######################\n",urlString);
        switch (requestType){
                //Request Type Get
            case RequestTypeGET:{
                [requestManager GET:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    DebugLog(@"Response Data\n######################\n\n%@\n\n######################\n\n",responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [operation.response statusCode];
                    if(responseObject){
                        completion(true,responseObject,tag,nil,operation.response.statusCode);
                    }else{
                        completion(false,nil,tag,responseObject,operation.response.statusCode);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    DebugLog(@"ERROR\n######################\n\n%@\n",error.localizedDescription);
                    DebugLog(@"Response Data\n\n%@\n\n######################\n",operation.responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    completion(false,nil,tag,error,operation.response.statusCode);
                    [self showNetworkErrorAlertWithError:error];
                }];
                break;
            }
                // Request Type Post
            case RequestTypePOST:{
                [requestManager POST:urlString  parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    DebugLog(@"Response Data\n######################\n\n%@\n\n######################\n\n",responseObject);
                    if(responseObject){
                        completion(true,responseObject,tag,nil,operation.response.statusCode);
                    }else{
                        completion(false,nil,tag,responseObject,operation.response.statusCode);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    DebugLog(@"ERROR\n######################\n\n%@\n",error.localizedDescription);
                    DebugLog(@"Response Data\n\n%@\n\n######################\n",operation.responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    completion(false,nil,tag,error,operation.response.statusCode);
                    [self showNetworkErrorAlertWithError:error];
                }];
                break;
            }
                //Request Type PUT
            case RequestTypePUT:{
                [requestManager PUT:urlString  parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    DebugLog(@"Response Data\n######################\n\n%@\n\n######################\n\n",responseObject);
                    if(responseObject){
                        completion(true,responseObject,tag,nil,operation.response.statusCode);
                    }else{
                        completion(false,nil,tag,responseObject,operation.response.statusCode);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    DebugLog(@"ERROR\n######################\n\n%@\n",error.localizedDescription);
                    DebugLog(@"Response Data\n\n%@\n\n######################\n",operation.responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    completion(false,nil,tag,error,operation.response.statusCode);
                    [self showNetworkErrorAlertWithError:error];
                }];
                break;
            }
                //Request Type Delete
            case RequestTypeDelete:{
                [requestManager DELETE:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    DebugLog(@"Response Data\n######################\n\n%@\n\n######################\n\n",responseObject);
                    if(responseObject){
                        completion(true,responseObject,tag,nil,operation.response.statusCode);
                    }else{
                        completion(false,nil,tag,responseObject,operation.response.statusCode);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    DebugLog(@"ERROR\n######################\n\n%@\n",error.localizedDescription);
                    DebugLog(@"Response Data\n\n%@\n\n######################\n",operation.responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    completion(false,nil,tag,error,operation.response.statusCode);
                    [self showNetworkErrorAlertWithError:error];
                }];
                break;
            }
            default:
                break;
        }

    }
    @catch (NSException *exception) {
        DebugLog(@"ERROR\n######################\n\n%@\n",exception.description);
        DebugLog(@"ERROR\n######################\n\n%@\n",exception.debugDescription);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        completion(false,nil,tag,nil,0);
    }
}

+(void)responseWithUrl:(NSString *)url andPostResponse:(NSDictionary *)parameters andImageData:(NSData *)imageData andIsImageChanged:(BOOL)isImageChanged andRequestType:(RequestType)requestType andRequiredAuthorization:(BOOL)requiredAuthorization andImageKey:(NSString *)imageKey andCompletetion:(void (^)(BOOL status,id responseObj, NSString *tag, NSError *error , NSInteger statusCode))completion{
    DebugLog(@"Request Parameter \n######################\n\n%@\n\n######################\n",parameters);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [requestManager.requestSerializer setValue:akRequestAcceptsType forHTTPHeaderField:@"Accepts"];
    [requestManager.requestSerializer setValue:akRequestContentType forHTTPHeaderField:@"Content-Type"];
    if(requiredAuthorization) [requestManager.requestSerializer setValue:akAutherizationToken forHTTPHeaderField:@"Authorization"];
    
    NSString *urlString = [url containsString:akAPIBaseURL]?url:[NSString stringWithFormat:@"%@%@",akAPIBaseURL,url];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *requestTypeString = (requestType == RequestTypePOST)?@"POST":@"PUT";
    NSMutableURLRequest *request = [requestManager.requestSerializer multipartFormRequestWithMethod:requestTypeString URLString:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        if (imageData && isImageChanged)
        [formData appendPartWithFileData:imageData name:imageKey fileName:[NSString stringWithFormat:@"%@.jpg",imageKey] mimeType:@"image/jpeg"];
    } error:nil];
    
    AFHTTPRequestOperation *requestOperation = [requestManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
        completion(true,responseObject,nil,nil,operation.response.statusCode);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(false,nil,nil,error,operation.response.statusCode);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    [requestOperation start];
}

@end
