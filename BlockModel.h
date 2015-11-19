//
//  BlockModel.h
//  TEST11
//
//  Created by dongjl on 15/11/18.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^blk_t) (void);
@interface BlockModel : NSObject {
    blk_t blk_;
}

@end
