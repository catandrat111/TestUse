//
//  MyWorkerClass.m
//  TEST11
//
//  Created by dongjl on 15/12/1.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "MyWorkerClass.h"

@implementation MyWorkerClass
+(void)LaunchThreadWithPort:(id)inData{

@autoreleasepool {
    
    // Set up the connection between this thread and the main thread.
//    NSPort* distantPort = (NSPort*)inData;
//    
//    MyWorkerClass*  workerObj = [[self alloc] init];
//    [workerObj sendCheckinMessage:distantPort];
//    // Let the run loop process things.
//    do
//    {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
//                                 beforeDate:[NSDate distantFuture]];
//    }
//    while (![workerObj shouldExit]);
    

}

}

// Worker thread check-in method
- (void)sendCheckinMessage:(NSPort*)outPort
{
    // Retain and save the remote port for future use.
//    [self setRemotePort:outPort];
//    
//    // Create and configure the worker thread port.
//    NSPort* myPort = [NSMachPort port];
//    [myPort setDelegate:self];
//    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
//    
//    // Create the check-in message.
//    NSPortMessage* messageObj = [[NSPortMessage alloc] initWithSendPort:outPort
//                                                            receivePort:myPort components:nil];
//    
//    if (messageObj)
//    {
//        // Finish configuring the message and send it immediately.
//        [messageObj setMsgId:setMsgid:kCheckinMessage];
//        [messageObj sendBeforeDate:[NSDate date]];
//    }
}

@end
