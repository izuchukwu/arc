//
//  ACConsole.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACConsole.h"

@implementation ACConsole

+ (void)start {
    [[ACConsoleInterface standardInterface] start];
}

#pragma mark - Input

+ (NSString *)inputForConsoleData:(ACConsoleData *)consoleData openEnded:(BOOL)openEnded {
    return [self inputForConsoleData:consoleData openEnded:openEnded withInputError:NO];
}

+ (NSString *)inputForConsoleData:(ACConsoleData *)consoleData openEnded:(BOOL)openEnded withInputError:(BOOL)inputError {
    if (inputError) {
        [self write:@"[!] Action's not quite right. Let's try again."];
        [self write:@""];
    }
    
    if ([consoleData title]) {
        [self write:[consoleData title]];
        [self write:@""];
    }
    
    if ([consoleData map]) {
        [self write:[consoleData map]];
        [self write:@""];
    }
    
    if ([consoleData status]) {
        [self write:[consoleData status]];
        [self write:@""];
    }
    
    if ([consoleData shouldRead]) {
        [self write:[NSString stringWithFormat:@"> %@", [consoleData prompt]]];
        
        NSString *input = [self readForPrompts:[consoleData actions]];
        [self write:@""];
        
        if (!openEnded) {
            for (NSString *action in [consoleData actions]) {
                NSString *actionInput = [input componentsSeparatedByString:@" "][0];
                
                if ([[actionInput lowercaseString] isEqualToString:[action lowercaseString]]) {
                    return input;
                } else {
                    return [self inputForConsoleData:consoleData openEnded:openEnded withInputError:YES];
                }
            }
        } else {
            return input;
        }
    }
    
    return nil;
}

#pragma mark - Terminal

+ (NSString *)readForPrompt:(NSString *)prompt {
    return [self readForPrompts:@[prompt]];
}

+ (NSString *)readForPrompts:(NSArray *)prompts {
    if (prompts) {
        for (NSString *prompt in prompts) {
            [self write:[NSString stringWithFormat:@"> %@", prompt]];
        }
    }
    [self write:@"> " withNewline:NO];
    
#if SHOULD_CLEAR_CONSOLE
    NSString *input = [self read];
    [self clear];
    return input;
#else
    return [self read];
#endif
}

+ (void)write:(NSString *)output{
    [self write:output withNewline:YES];
}

#pragma mark - I/O

+ (NSString *)read {
    NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
    NSData *inputData = [input availableData];
    
    return [[[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

+ (void)write:(NSString *)output withNewline:(BOOL)withNewline {
    printf("%s%s", [output UTF8String], (withNewline ? "\n" : ""));
}

+ (BOOL)clear {
    NSString *const scriptText = @"\
    tell application \"System Events\"\n\
    set currentapp to the name of the current application\n\
    end tell\n\
    tell application \"Xcode\" to activate\n\
    tell application \"System Events\"\n\
    keystroke \"k\" using {command down}\n\
    end tell\n\
    tell application currentapp to activate\n\
    return true";
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
    NSDictionary *dictError = nil;
    NSAppleEventDescriptor *result = [script executeAndReturnError:&dictError];
    
    if (!result) return false;
    if ([result booleanValue] != YES) return false;
    return true;
}

@end
