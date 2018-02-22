//
//  BatteryViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Foundation
import IOKit.ps




import Cocoa

class BatterViewController : NSTextField {
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.stringValue = getCapacity()
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.71, green: 0.54, blue: 0.00, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 60*2, repeats: true) { _ in
			self.stringValue = self.getCapacity()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func getCapacity() -> String {
		let psInfo = IOPSCopyPowerSourcesInfo().takeRetainedValue()
		let psInfoArray = (psInfo as! [[String: Any]])[0]
		if let capacity = psInfoArray["Current Capacity"] as? Int {
			return String(capacity) + "%"
		} else {
			return "ERR"
		}
	}
}
