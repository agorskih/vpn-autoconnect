--
--  VPNService.applescript
--  VPN service
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSTimer : class "NSTimer"
property NullVPNService : class "NullVPNService"
property FooVPNService : class "VPNService"

script VPNService
	property parent : class "NSObject"
    property identifier : missing value
    property dialer : null

-- Class methods:
    
    to createNullService()
        return the new of NullVPNService
    end

    to createService_(vpn)
        set service to the new of FooVPNService
        set service's identifier to vpn as string
        return service
    end

    -- Constants 10, 12, 15 in this method were found by brute-forcing vpn connection types
    -- May be some values are missing. Tell me if that so.
    on connections()
        tell application "System Events"
            tell current location of network preferences
                return name of every service whose (kind is 10) or (kind is 12) or (kind is 15)
            end tell
        end tell
    end

-- Public methods:

    -- This method can use flag activated in enable/disable method
    -- But it's better to check dialer's existence
    -- You could equally use isValid method here
    on autoconnected()
        return my dialer isn't null
    end

    to enable()
        tell me to disable()
        set my dialer to NSTimer's scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(1, me, "reconnect:", null, true)
    end

    to disable()
        tell me to releaseTimer()
        tell me to disconnect()
    end

-- Private methods:
-- Following methods don't validate vpn name
-- It's better to crash then give user the illusion of safety

    to reconnect_(sender)
        tell application "System Events"
            tell current location of network preferences
                connect service my identifier
            end tell
        end tell
    end

    to disconnect()
        tell application "System Events"
            tell current location of network preferences
                disconnect service my identifier
            end tell
        end tell
    end

    to releaseTimer()
        if autoconnected() then
            my dialer's invalidate()
            set my dialer to null
        end if
    end

end script