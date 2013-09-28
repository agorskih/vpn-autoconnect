--
--  AppDelegate.applescript
--  VPN Autoconnect
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSStatusBar : class "NSStatusBar"
property NSBundle : class "NSBundle"
property VPNStatusViewController : class "VPNStatusViewController"

script AppDelegate
	property parent : class "NSObject"
    property menuController : missing value
	
	to applicationWillFinishLaunching_(notification)
        createMenuController()
        createMenu()
	end
    
    to createMenuController()
        set my menuController to the new of VPNStatusViewController
        my menuController's loadView()
    end
    
    to createMenu()
        set statusItem to my statusBarItem()
        statusItem's setTitle_(my applicationName())
        statusItem's setHighlightMode_(true)
        statusItem's setMenu_(my menuController's view)
    end

    on statusBarItem()
        set statusBar to systemStatusBar of NSStatusBar
        return statusBar's statusItemWithLength_(-1)'s retain
    end
    
    on applicationName()
        set bundle to mainBundle of NSBundle
        return bundle's infoDictionary's CFBundleName
    end
    
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end
	
end script