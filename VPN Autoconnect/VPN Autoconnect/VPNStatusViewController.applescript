--
--  VPNStatusViewController.applescript
--  VPN Autoconnect status view controller
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSMenu : class named "NSMenu"
property NSMenuItem : class named "NSMenuItem"
property VPNConnection : class named "VPNConnection"

script VPNStatusViewController
	property parent : class named "NSObject"
	property view :missing value
    property model : missing value
    property turnOnItem : missing value
    property turnOffItem : missing value
    property quitItem : missing value
    
    on loadView()
        set my view to the new of NSMenu
        set my model to the new of VPNConnection
        set my turnOnItem to createTurnOnItem()
        set my turnOffItem to createTurnOffItem()
        set my quitItem to createQuitItem()
        my view's setDelegate_(me)
    end
    
    on menuNeedsUpdate_(menu)
        my view's removeAllItems()
        my view's addItem_(turnOnItem)
        my view's addItem_(turnOffItem)

        repeat with vpn in model's availableVPNs()
            my view's addItem_(createServiceItem from vpn)
        end repeat
        
        my view's addItem_(quitItem)
    end

    to createItem given title:aTitle, action:aHandler, visible:isVisible
        set viewItem to NSMenuItem's new()
        viewItem's setTitle_(aTitle)
        viewItem's setTarget_(me)
        viewItem's setHidden_(not isVisible)
        viewItem's setAction_(aHandler)
        return viewItem
    end
    
    to createServiceItem from vpn
        return createItem given title:vpn, action:"setVPN:", visible:true
    end

    to createTurnOnItem()
        return createItem given title:"Turn On", action:"turnOn:", visible:true
    end

    to createTurnOffItem()
        return createItem given title:"Turn Off", action:"turnOff:", visible:false
    end

    to createQuitItem()
        return createItem given title:"Quit", action:"quit:", visible:true
    end

    to turnOn_(sender)
        my turnOnItem's setHidden_(true)
        my turnOffItem's setHidden_(false)
    end

    to turnOff_(sender)
        my turnOnItem's setHidden_(false)
        my turnOffItem's setHidden_(true)
    end

    to setVPN_(sender)
    end

    to quit_(sender)
        tell me to quit
    end

end script