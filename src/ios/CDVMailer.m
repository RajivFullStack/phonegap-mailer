#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Cordova/CDV.h>

@interface CDVMailer : CDVPlugin <MFMailComposeViewControllerDelegate> {
    NSString *pgCallbackId;
}
- (void)compose:(CDVInvokedUrlCommand*)command;
@end

@implementation CDVMailer

- (void)compose:(CDVInvokedUrlCommand *)command {
    NSString *subject = [command.arguments objectAtIndex:0];
    NSString *body = [command.arguments objectAtIndex:1];
    NSString *attachment = [command.arguments objectAtIndex:2];

    pgCallbackId = command.callbackId;

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    if(subject != nil)
        [picker setSubject:subject];
    if(body != nil)
        [picker setMessageBody:body isHTML:NO];
    // TODO: handle attachment
    [self.viewController presentModalViewController:picker animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {   
    int jsResult = 0;
    switch (result) {
        case MFMailComposeResultCancelled:
			jsResult = 1;
            break;
        case MFMailComposeResultSaved:
			jsResult = 2;
            break;
        case MFMailComposeResultSent:
			jsResult = 3;
            break;
        case MFMailComposeResultFailed:
            jsResult = 4;
            break;
        default:
			jsResult = 0;
            break;
    }
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:jsResult];
    [self.viewController dismissModalViewControllerAnimated:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:pgCallbackId];
}

@end
