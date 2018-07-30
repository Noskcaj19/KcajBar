//
//  DateViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class DateViewController : NSTextField, Component {
    var hovering = false
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.15, green: 0.55, blue: 0.82, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 60*10, repeats: true) { _ in
            self.updateField()
        }
        updateField()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    @objc func updateField() {
        self.stringValue = getDate(short: hovering)
    }

    func getDate(short: Bool) -> String {
		let date = Date()
		let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = short ? "mm/dd/yy" : "EEE dd MMM"
		return dateFormatter.string(from: date)
	}
    
    override func mouseEntered(with event: NSEvent) {
        self.hovering = true
        updateField()
    }
    
    override func mouseExited(with event: NSEvent) {
        self.hovering = false
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateField), userInfo: nil, repeats: false)
    }
    
    func viewDidAppear() {
        let area = NSTrackingArea.init(rect: self.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(area)
    }
}
