--
--  ConnectionIndication.applescript
--  Connection Indication
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSUserNotification : class "NSUserNotification"
property NSUserNotificationCenter : class "NSUserNotificationCenter"

script ConnectionIndication
	property parent : class "NSObject"
    
    -- Usage: notify about "Connection failure" given description:"VPN is disconnected"
    to notify about title given description:informativeText
        set notification to NSUserNotification's new's autorelease
        notification's setTitle_(title)
        notification's setInformativeText_(informativeText)
        NSUserNotificationCenter's defaultUserNotificationCenter's scheduleNotification_(notification)
    end

end script