--
--  VPNConnection.applescript
--  VPN connection model
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSTimer : class "NSTimer"

script VPNService
	property parent : class "NSObject"
    property name : "" -- Implement getter to check active VPN connection or use default
    property autoconnected : false

    on connections()
        tell application "System Events"
            tell current location of network preferences
                return name of every service whose (kind is 10) or (kind is 12) or (kind is 15)
            end tell
        end tell
    end
    
    on connected()
        tell application "System Events"
            tell current location of network preferences
                if service my name exists then
                    return connected of current configuration of service my name
                end if
            end tell
        end tell
    end
    
    to enable()
        set my autoconnected to true
        NSTimer's scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(1, me, "reconnect:", null, true)
    end

    to disable()
        set my autoconnected to false
    end

    to invalidate()
        disable()
        set my name to ""
    end

    to reconnect_(sender)
        if autoconnected then
            tell me to connect()
        else
            sender's invalidate()
            tell me to disconnect()
        end if
        tell me to log "Tick"
    end

    to connect()
        tell application "System Events"
            tell current location of network preferences
                if service my name exists then
                    connect service my name
                end if
            end tell
        end tell
    end

    to disconnect()
        tell application "System Events"
            tell current location of network preferences
                if service my name exists then
                    disconnect service my name
                end if
            end tell
        end tell
    end

end script