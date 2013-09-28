--
--  VPNStatusViewController.applescript
--  VPN Autoconnect status view controller
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSMenu : class named "NSMenu"
property NSMenuItem : class named "NSMenuItem"
property VPNService : class named "VPNService"

script VPNStatusViewController
	property parent : class named "NSObject"
	property view :missing value
    property model : missing value
    property quitItem : missing value
    
    on loadView()
        set my view to the new of NSMenu
        set my model to the new of VPNService
        set my quitItem to newQuitItem()
        my view's setDelegate_(me)
    end
    
    on menuNeedsUpdate_(menu)
        my view's removeAllItems()
        my view's addItem_(newSwitchItem())
        addConnections into my view
        my view's addItem_(quitItem)
    end
    
    to addConnections into container
        repeat with vpn in my model's availableVPNs()
            container's addItem_(newConnection from vpn)
        end repeat
    end

    on newConnection from vpn
        set connection to the newItem given title:vpn, action:"connectionSelection:"
        if model's name equals (vpn as string) then
            connection's setState_(true)
        end if
        return connection
    end

    on newSwitchItem()
        if model's autoconnected then
            return newItem given title:"Turn Off", action:"switch:"
        else
            return newItem given title:"Turn On", action:"switch:"
        end if
    end

    on newQuitItem()
        return newItem given title:"Quit", action:"quit:"
    end

    on newItem given title:aTitle, action:aHandler
        set element to the new of NSMenuItem
        element's setTitle_(aTitle)
        element's setTarget_(me)
        element's setAction_(aHandler)
        return element
    end

    to switch_(sender)
        if model's autoconnected then
            model's disconnect()
        else
            if model's name equals "" then
                display alert "No connection selected."
            else
                model's connect()
            end if
        end if
    end

    to getLabel given status:connected
        if connected then
            return "Turn Off"
        else
            return "Turn On"
        end if
    end

    on connectionSelection_(sender)
        model's disconnect()
        if (state of sender as boolean) equals true then
            model's setName given service:"" --prevent connection
        else
            model's setName given service:sender's title
        end if
    end

    to quit_(sender)
        my model's disconnect()
        tell current application to quit
    end

end script