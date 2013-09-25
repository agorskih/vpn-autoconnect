--
--  VPNStatusViewController.applescript
--  VPN Autoconnect status view controller
--
--  Created by Alexander Gorskih on 25.09.13.
--  Copyright (c) 2013 Alexander Gorskih. All rights reserved.
--  MIT-style copyright and disclaimer apply

property NSMenu : class "NSMenu"
property NSMenuItem : class "NSMenuItem"
property VPNConnection : class "VPNConnection"

script VPNStatusViewController
	property parent : class "NSObject"
	property view : missing value
    property model : missing value
    
    on loadView()
        set view to NSMenu's new()
        set model to VPNConnection's new()
        addTurnOnItem()
        addTurnOffItem()
        addQuitItem()
    end loadView
    
    on addTurnOnItem()
        set viewItem to NSMenuItem's new()
        viewItem's setTitle_("Turn On")
        view's addItem_(viewItem)
    end addTurnOnItem
    
    on addTurnOffItem()
        set viewItem to NSMenuItem's new()
        viewItem's setTitle_("Turn Off")
        viewItem's setHidden_(true)
        view's addItem_(viewItem)
    end addTurnOnItem
    
    on addQuitItem()
        set viewItem to NSMenuItem's new()
        viewItem's setTitle_("Quit")
        view's addItem_(viewItem)
    end addTurnOnItem
    
end script