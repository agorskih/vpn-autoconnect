--
--  VPNConnection.applescript
--  VPN connection model
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

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
    
    to connect()
        set my autoconnected to true
        tell application "System Events"
            tell current location of network preferences
                if service my name exists then
                    connect service my name
                end if
            end tell
        end tell
    end

    to disconnect()
        set my autoconnected to false
        tell application "System Events"
            tell current location of network preferences
                if service my name exists then
                    disconnect service my name
                end if
            end tell
        end tell
    end

end script