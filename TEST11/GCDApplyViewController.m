//
//  GCDApplyViewController.m
//  TEST11
//
//  Created by dongjl on 15/9/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "GCDApplyViewController.h"

@interface GCDApplyViewController ()

@end

@implementation GCDApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self test_dispatch_semaphore];
    //[self test_dispatch_apply];
   // [self test_dispatch_barrier_async];
    [self test_dispatch_semaphore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)test_dispatch_io{
    dispatch_fd_t fd;
    dispatch_queue_t pipe_q = dispatch_queue_create("pipeQ", DISPATCH_QUEUE_SERIAL);
    dispatch_io_t pipe_channel = dispatch_io_create(DISPATCH_IO_STREAM, fd, pipe_q, ^(int error) {
        close(fd);
    });
    //fdpir[1];
    
}

//dispatch_semaphore 信号量基于计数器的一种多线程同步机制。在多个线程访问共有资源时候，会因为多线程的特性而引发数据出错的问题。
-(void)test_dispatch_semaphore{
    //    //dispatch_semaphore的计数为0时等待，计数大于等于1时不等待减一
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    //    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    //
    //    //等待直到dispatch_semaphore大于等于1,这里会阻塞当前线程。直到返回
    //    long result = dispatch_semaphore_wait(semaphore, time);
    //    if (result == 0) {
    //        //此时信号量大于等于1，可以执行需要进行的排他控制的处理，同时信号量减一
    //    }else{
    //        //到达指定时间以后，此时信号量等于0，
    //    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);//信号为1
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < 10000; ++i) {
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//信号量减一
            [array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);//信号量加一
        });
    }
    NSLog(@"%@",array);
    
}






-(void)test_dispatch_suspend
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_suspend挂起指定的queue
    dispatch_suspend(queue);
    //dispatch_resume恢复指定的queue
    dispatch_resume(queue);
    
}



-(void)test_dispatch_apply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //把指定的任务执行指定次数，直到执行完毕才函数才返回。
//    dispatch_apply(5, queue, ^(size_t index) {
//         NSLog(@"%zu",index);
////        2015-09-24 16:32:49.073 TEST11[2930:342198] 0
////        2015-09-24 16:32:49.074 TEST11[2930:342198] 1
////        2015-09-24 16:32:49.075 TEST11[2930:342240] 2
////        2015-09-24 16:32:49.075 TEST11[2930:342198] 3
////        2015-09-24 16:32:49.076 TEST11[2930:342240] 4
//    });
    //=================================================
    //因为dispatch_apply是同步函数，所以推荐在非同步函数中使用这个方法
//    NSArray *array = @[@"q",@"w",@"e",@"r"];
//    dispatch_async(queue, ^{
//        dispatch_apply([array count], queue, ^(size_t index) {
//            NSLog(@"%zu: %@",index,[array objectAtIndex:index]);
//        });
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Done11111");
//        });
//        
//    });
//    NSLog(@"Done");
    
    
//    2015-09-24 16:34:41.553 TEST11[2947:342621] Done
//    2015-09-24 16:34:41.554 TEST11[2947:342665] 0: q
//    2015-09-24 16:34:41.555 TEST11[2947:342665] 1: w
//    2015-09-24 16:34:41.556 TEST11[2947:342665] 2: e
//    2015-09-24 16:34:41.556 TEST11[2947:342665] 3: r
//    2015-09-24 16:34:41.575 TEST11[2947:342621] Done11111
    
    
    NSArray *array = [NSArray arrayWithObjects:@"/Users/chentao/Desktop/copy_res/gelato.ds",
                      @"/Users/chentao/Desktop/copy_res/jason.ds",
                      @"/Users/chentao/Desktop/copy_res/jikejunyi.ds",
                      @"/Users/chentao/Desktop/copy_res/molly.ds",
                      @"/Users/chentao/Desktop/copy_res/zhangdachuan.ds",
                      nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
        dispatch_apply([array count], dispatch_get_global_queue(0, 0), ^(size_t index){
            NSLog(@"copy-%@", array[index]);
        });
        NSLog(@"done");
    });
}

//dispatch_barrier_async是在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行。
- (void)test_dispatch_barrier_async {
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4];
        
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async3"); 
    });
    
//    2015-09-24 16:50:30.049 TEST11[3008:344734] dispatch_async1
//    2015-09-24 16:50:32.049 TEST11[3008:344735] dispatch_async2
//    2015-09-24 16:50:32.051 TEST11[3008:344735] dispatch_barrier_async
//    2015-09-24 16:50:37.057 TEST11[3008:344735] dispatch_async3
//
}

- (void)test_dispatch_group {
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk0");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk2");
    });
    //group中的所有任务都结束以后，才把开始执行这里的任务。group执行完以后才能把任务加入主队列
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"done");
    });
    
    
    //
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    //这个函数用于判断经过指定时间以后，group里面的任务是否完成，如果完成，返回0，如果不等于0，则是没有完成。
    //这里的等待的意思是，当前线程会处于阻塞状态且dispatch_group_wait方法处于调用状态，知道group任务完成或者指定时间结束。
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        //属于Dispatch Group的全部处理执行结束
    }else{
        //属于Dispatch Group的有处理没有执行结束
    }

}

@end
