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
    property statusViewController : missing value
	
	on applicationWillFinishLaunching_(aNotification)
        createAutoconnectMenuController()
        addAutoconnectMenuToStatusBar()
	end applicationWillFinishLaunching_
    
    on createAutoconnectMenuController()
        set statusViewController to VPNStatusViewController's new()
        statusViewController's loadView()
    end createAutoconnectMenuController
    
    on addAutoconnectMenuToStatusBar()
        set statusBar to NSStatusBar's systemStatusBar()
        set autoconnectMenu to statusBar's statusItemWithLength_(-1)'s retain
        set bundle to NSBundle's mainBundle
        set title to bundle's infoDictionary's CFBundleName
        
        autoconnectMenu's setTitle_(title)
        autoconnectMenu's setHighlightMode_(true)
        autoconnectMenu's setMenu_(statusViewController's view)
    end addAutoconnectMenuToStatusBar
    
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script