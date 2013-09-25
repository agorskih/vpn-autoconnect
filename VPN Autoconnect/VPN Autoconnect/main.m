//
//  main.m
//  VPN Autoconnect
//
//  Created by Alexander Gorskih on 25.09.13.
//  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, (const char **)argv);
}
