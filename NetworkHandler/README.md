# What is NetworkHandler?
NetworkHandler is a wrapper of AFNetworking. NetworkHandler provide simple way to manage requests.

# Methods

For cancell all ongoing request
```objective-c
+(void)cancelAllRequest;
```

For checking network reachability
```objective-c
+(void)checkReachabilityWithSuccess:(void(^)())success andFailed:(void(^)())failed;
```

For simple request
```objective-c
+(void)requestWithUrl:(NSString *)url andRequestParameter:(id)parameter andRequestType:(RequestType)requestType andRequiredAuthorization:(BOOL)requiredAuthorization andTag:(NSString *)tag andCompletetion:(void (^)(BOOL status,id responseObj, NSString *tag, NSError *error , NSInteger statusCode))completion;
```

For multipart request
```objective-c
+(void)responseWithUrl:(NSString *)url andPostResponse:(NSDictionary *)parameters andImageData:(NSData *)imageData andIsImageChanged:(BOOL)isImageChanged andRequestType:(RequestType)requestType andRequiredAuthorization:(BOOL)requiredAuthorization andImageKey:(NSString *)imageKey andCompletetion:(void (^)(BOOL status,id responseObj, NSString *tag, NSError *error , NSInteger statusCode))completion
```

# How to use NetworkHandler?

Cancel all on going request
```objective-c
[NetworkHandler cancelAllRequest];
```
Check network reachability and perform operation based on result
```objective-c
[NetworkHandler checkReachabilityWithSuccess:^{
//internet access
} andFailed:^{
//no internet access
}];
```
Request
```objective-c
[NetworkHandler requestWithUrl:url andRequestParameter:nil andRequestType:RequestTypeGET andRequiredAuthorization:NO andTag:@"identicalTag" andCompletetion:^(BOOL status, id responseObj, NSString *tag, NSError *error, NSInteger statusCode) {
    if(status){
    //success with responseObj
    }else{
    //failed
    }
}];
```

