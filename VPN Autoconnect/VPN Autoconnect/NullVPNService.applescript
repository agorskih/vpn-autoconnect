--
--  NullVPNService.applescript
--  Null VPN service model
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

script NullVPNService
	property parent : class "NSObject"
    property identifier : ""
    property autoconnected : false
    
    to enable()
        display alert "No connection selected."
    end

    to disable()
        --display alert "No connection selected."
    end

    to invalidate()
        --display alert "No connection selected."
    end

    to connect()
        display alert "No connection selected."
    end

    to disconnect()
        display alert "No connection selected."
    end

end script