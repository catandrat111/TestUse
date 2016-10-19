//
//  PHPhotoLibrary+ZHCustomPhotoAlbum.h
//  zsch
//
//  Created by dongjl on 16/10/12.
//  Copyright © 2016年 WYD. All rights reserved.
//
#import <Photos/Photos.h>
typedef void(^SaveImageCompletion)(NSError* error);

@interface PHPhotoLibrary (ZHCustomPhotoAlbum)
 +(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
@end




