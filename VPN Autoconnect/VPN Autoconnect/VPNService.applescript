--
--  VPNConnection.applescript
--  VPN connection model
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

script VPNConnection
	property parent : class "NSObject"
    property defaultConnection : "" -- Implement getter to check active VPN connection or use default
    
    to setDefaultConnection given service:VPNName
        set defaultConnection to VPNName as string
    end
    
    on availableVPNs()
        tell application "System Events"
            tell current location of network preferences
                return name of every service whose (kind is 10) or (kind is 12) or (kind is 15)
            end tell
        end tell
    end availableVPNs
end script