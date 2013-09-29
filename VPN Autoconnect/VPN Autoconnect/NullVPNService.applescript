--
--  NullVPNService.applescript
--  Null VPN service
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

script NullVPNService
	property parent : class "VPNService"
    property identifier : ""
    
-- Public methods:
    
    on autoconnected()
        return false
    end
    
    to enable()
        display alert "No connection selected."
    end

    to disable()
        -- do nothing
    end

end script