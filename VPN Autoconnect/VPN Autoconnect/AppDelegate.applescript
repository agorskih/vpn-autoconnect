--
--  AppDelegate.applescript
--  VPN Autoconnect
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSStatusBar : class "NSStatusBar"

script AppDelegate
	property parent : class "NSObject"
    property statusBar : missing value
	
	on applicationWillFinishLaunching_(aNotification)
        set statusBar to NSStatusBar's systemStatusBar()
        addAutoconnectMenuToStatusBar()
	end applicationWillFinishLaunching_
    
    on addAutoconnectMenuToStatusBar()
        set autoconnectMenu to statusBar's statusItemWithLength_(-1)
        autoconnectMenu's setTitle_("VPN Autoconnect")
        autoconnectMenu's setHighlightMode_(true)
    end addAutoconnectMenuToStatusBar
    
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script