//
//  WifiViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class WifiViewController : NSTextField, Component {
    var currentWifi: WifiStatus
    var hovering = false
    var trackingArea: NSTrackingArea?
	override init(frame frameRect: NSRect) {
        currentWifi = wifiStatus()
        super.init(frame: frameRect)
        
        self.usesSingleLineMode = true
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.52, green: 0.60, blue: 0.00, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 60*2, repeats: true) { _ in
            self.currentWifi = wifiStatus()
            self.updateField()
		}
        updateField()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    override func mouseEntered(with event: NSEvent) {
        self.hovering = true
        updateField()
    }
    
    override func mouseExited(with event: NSEvent) {
        self.hovering = false
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateField), userInfo: nil, repeats: false)
    }
    
    @objc func updateField() {
        switch wifiStatus() {
        case let .on(networkName):
            if hovering {
                self.stringValue = networkName
            } else {
                self.stringValue = "on"
            }
        case .off:
            self.stringValue = "off"
        }
    }

    func viewDidAppear() {
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways, .assumeInside], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let area = trackingArea {
            self.removeTrackingArea(area)
        }
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways, .assumeInside], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
}
