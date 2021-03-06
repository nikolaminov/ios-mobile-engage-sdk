//
//  Copyright © 2017 Emarsys. All rights reserved.
//

#import "MEIAMTriggerAppEvent.h"
#import "MEInAppMessageHandler.h"
#import "MEIAMCommamndResultUtils.h"

@interface MEIAMTriggerAppEvent()

@property(nonatomic, weak, nullable) id <MEInAppMessageHandler> inAppMessageHandler;

@end

@implementation MEIAMTriggerAppEvent

- (instancetype)initWithInAppMessageHandler:(id <MEInAppMessageHandler>)inAppMessageHandler {
    if (self = [super init]) {
        _inAppMessageHandler = inAppMessageHandler;
    }
    return self;
}


+ (NSString *)commandName {
    return @"triggerAppEvent";
}

- (void)handleMessage:(NSDictionary *)message
          resultBlock:(MEIAMJSResultBlock)resultBlock {
    NSString *name = message[@"name"];
    NSDictionary *payload = message[@"payload"];
    NSString *eventId = message[@"id"];
    if (name) {
        [self.inAppMessageHandler handleApplicationEvent:name
                                                 payload:payload];
        resultBlock([MEIAMCommamndResultUtils createSuccessResultWith:eventId]);
    } else {
        resultBlock([MEIAMCommamndResultUtils createMissingParameterErrorResultWith:eventId
                                                                   missingParameter:@"name"]);
    }
}

@end
