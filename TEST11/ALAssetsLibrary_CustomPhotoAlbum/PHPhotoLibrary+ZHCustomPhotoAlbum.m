//
//  PHPhotoLibrary+ZHCustomPhotoAlbum.m
//  zsch
//
//  Created by dongjl on 16/10/12.
//  Copyright © 2016年 WYD. All rights reserved.
//

#import "PHPhotoLibrary+ZHCustomPhotoAlbum.h"
#import "SVProgressHUD.h"
#import "DQAlertView.h"

@implementation PHPhotoLibrary (ZHCustomPhotoAlbum)
+(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock {
//    // 0.判断状态
//    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//    if (status == PHAuthorizationStatusDenied) {
//        DLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
//        DQAlertView* alertView = [[DQAlertView alloc] initWithTitle:nil message:@"保存失败，请在\"设置-隐私-照片中\"，开启访问相册权限" cancelButtonTitle:@"确定" otherButtonTitle:nil];
//        [alertView show];
//        return;
//    }else if (status == PHAuthorizationStatusRestricted){
//        DLog(@"家长控制,不允许访问");
//        [SVProgressHUD showErrorWithStatus:@"系统原因，无法访问相册"];
//        return;
//    }else if (status == PHAuthorizationStatusNotDetermined){
//        DLog(@"用户还没有做出选择");
//        [[self class] saveImage:image albumName:albumName withCompletionBlock:(SaveImageCompletion)completionBlock];
//    }else if (status == PHAuthorizationStatusAuthorized){
//        DLog(@"用户允许当前应用访问相册");
//        [[self class] saveImage:image albumName:albumName withCompletionBlock:(SaveImageCompletion)completionBlock];
//    }
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
     PHAuthorizationStatus lastStatus = [PHPhotoLibrary authorizationStatus];
    
    if(status == PHAuthorizationStatusDenied) //用户拒绝（可能是之前拒绝的，有可能是刚才在系统弹框中选择的拒绝）
    {
        if (lastStatus == PHAuthorizationStatusNotDetermined) {
            //说明，用户之前没有做决定，在弹出授权框中，选择了拒绝
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            });
            return;
        }
        // 说明，之前用户选择拒绝过，现在又点击保存按钮，说明想要使用该功能，需要提示用户打开授权
        DQAlertView* alertView = [[DQAlertView alloc] initWithTitle:nil message:@"保存失败，请在\"设置-隐私-照片中\"，开启访问相册权限" cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alertView show];
        return;
        
    }
    else if(status == PHAuthorizationStatusAuthorized) //用户允许
    {
        //保存图片---调用上面封装的方法
        [[self class] saveImage:image albumName:albumName withCompletionBlock:(SaveImageCompletion)completionBlock];
    }
    else if (status == PHAuthorizationStatusRestricted)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"系统原因，无法访问相册"];
        });
      
        return;
    }
 }];

}


+ (void)saveImage:(UIImage*)img albumName:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock{
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetId = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改"性质的代码
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
        assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:img].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            DLog(@"保存图片到相机胶卷中失败");
            completionBlock(error);
            return;
        }
        
        DLog(@"成功保存图片到相机胶卷中");
        if (assetId.length == 0) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }];
           
            return;
        }
        // 2. 获得相册对象
        PHAssetCollection *collection = [[self class] collection:albumName];
        
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                DLog(@"添加图片到相册中失败");
                completionBlock(error);
                return;
            }
            
            completionBlock(nil);
        }];
    }];
}


/**
 *  返回相册
 */
+ (PHAssetCollection *)collection:(NSString*)albumName{
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:albumName]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


@end
