--
--  VPNService.applescript
--  VPN service model
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
    property autoconnected : false
    property dialer : null
    
    to createNullService()
        return the new of NullVPNService
    end

    to createService_(vpn)
        set service to the new of FooVPNService
        set service's identifier to vpn as string
        return service
    end

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
                if service identifier exists then
                    return connected of current configuration of service identifier
                end if
            end tell
        end tell
    end

    to enable()
        disable()
        set my autoconnected to true
        set dialer to NSTimer's scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(1, me, "reconnect:", null, true)
    end

    to disable()
        set autoconnected to false
        if dialer isn't null then
            dialer's invalidate()
            set dialer to null
        end if
        disconnect()
    end

    to reconnect_(sender)
        connect()
        tell me to log "Tick"
    end

    to connect()
        tell application "System Events"
            tell current location of network preferences
                if service identifier exists then
                    connect service identifier
                end if
            end tell
        end tell
    end

    to disconnect()
        tell application "System Events"
            tell current location of network preferences
                if service identifier exists then
                    disconnect service identifier
                end if
            end tell
        end tell
    end

end script