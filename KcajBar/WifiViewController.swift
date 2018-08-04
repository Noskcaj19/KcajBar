//
//  WifiViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class WifiViewController: NSTextField, Component {
    var currentWifi: WifiStatus
    var hovering = false
    var trackingArea: NSTrackingArea?
    override init(frame frameRect: NSRect) {
        currentWifi = wifiStatus()
        super.init(frame: frameRect)

        usesSingleLineMode = true
        font = NSFont(name: "Hack", size: 12)
        textColor = NSColor(red: 0.52, green: 0.60, blue: 0.00, alpha: 1.0)
        backgroundColor = .clear
        isBezeled = false
        drawsBackground = false
        isSelectable = false
        isEditable = false
        Timer.scheduledTimer(withTimeInterval: 60 * 2, repeats: true) { _ in
            self.currentWifi = wifiStatus()
            self.updateField()
        }
        updateField()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseEntered(with _: NSEvent) {
        hovering = true
        updateField()
    }

    override func mouseExited(with _: NSEvent) {
        hovering = false
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateField), userInfo: nil, repeats: false)
    }

    @objc func updateField() {
        switch wifiStatus() {
        case let .on(networkName):
            if hovering {
                stringValue = networkName
            } else {
                stringValue = "on"
            }
        case .off:
            stringValue = "off"
        }
    }

    func viewDidAppear() {
        trackingArea = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .assumeInside], owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let area = trackingArea {
            removeTrackingArea(area)
        }
        trackingArea = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .assumeInside], owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
}
