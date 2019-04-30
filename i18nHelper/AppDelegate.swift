//
//  AppDelegate.swift
//  i18nHelper
//
//  Created by Chen Defore on 2019/4/11.
//  Copyright © 2019 IGG. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        FNHUD.setup()
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

