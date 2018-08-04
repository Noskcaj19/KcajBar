//
//  AppDelegate.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var newWindow: NSWindow?
    var controller: StatusBarViewController?

    func applicationDidFinishLaunching(_: Notification) {
        guard let screen = NSScreen.main else {
            return
        }
        newWindow = NSWindow(contentRect: screen.frame, styleMask: .borderless, backing: .buffered, defer: false)

        newWindow?.backgroundColor = .clear
        newWindow?.isOpaque = false
        newWindow?.level = NSWindow.Level(rawValue: -1)
        newWindow?.collectionBehavior = [.transient, .canJoinAllSpaces, .ignoresCycle]
        newWindow?.isRestorable = false
        newWindow?.disableSnapshotRestoration()
        newWindow?.displaysWhenScreenProfileChanges = true
        newWindow?.isReleasedWhenClosed = false
        newWindow?.ignoresMouseEvents = true

        controller = StatusBarViewController(with: screen)

        let content = newWindow!.contentView! as NSView

        let view = controller!.view
        content.addSubview(view)

        newWindow!.makeKeyAndOrderFront(nil)
    }
}
