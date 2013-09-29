--
--  VPNStatusViewController.applescript
--  VPN Autoconnect status view controller
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSMenu : class "NSMenu"
property NSMenuItem : class "NSMenuItem"
property VPNService : class "VPNService"

script VPNStatusViewController
	property parent : class "NSObject"
	property view :missing value
    property model : missing value
    
    to loadView()
        set my view to the new of NSMenu
        set my model to VPNService's createNullService()
        my view's setDelegate_(me)
    end
    
    on menuNeedsUpdate_(menu)
        my view's removeAllItems()
        my view's addItem_(newSwitchItem())
        addConnections to my view
        my view's addItem_(newQuitItem())
    end
    
    to addConnections to container
        repeat with vpn in VPNService's connections()
            container's addItem_(newConnection from vpn)
        end repeat
    end

    on newConnection from vpn
        set connection to the newItem given title:vpn, action:"connectionSelected:"
        connection's setState_(vpn as string equals model's identifier as string)
        return connection
    end

    on newSwitchItem()
        if model's autoconnected() then
            return newItem given title:"Turn Off", action:"switch:"
        else
            return newItem given title:"Turn On", action:"switch:"
        end if
    end

    on newQuitItem()
        return newItem given title:"Quit", action:"quit:"
    end

    on newItem given title:name, action:callback
        set element to the new of NSMenuItem
        element's setTitle_(name)
        element's setTarget_(me)
        element's setAction_(callback)
        return element's autorelease
    end

    to switch_(sender)
        if model's autoconnected() then
            model's disable()
        else
            model's enable()
        end if
    end

    on connectionSelected_(element)
        my model's disable()
        set my model to VPNService's createNullService()
        if element's state as boolean isn't true then
            set model to VPNService's createService_(element's title)
        end if
    end

    to quit_(sender)
        my model's disable()
        tell current application to quit
    end

end script