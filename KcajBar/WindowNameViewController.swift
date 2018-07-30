//
//  WindowNameViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class WindowNameViewController : NSTextField, Component {
    var windowName: String = ""
    var desktopNumber: String? = nil
    
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
        self.usesSingleLineMode = true
		self.stringValue = getWindowName()
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.147, green: 0.571, blue: 0.525, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
        
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.updateAll()
		}

		let simple_events = [
			NSWorkspace.sessionDidBecomeActiveNotification,
			NSWorkspace.sessionDidResignActiveNotification
		]

		for event in simple_events {
			NSWorkspace.shared.notificationCenter.addObserver(
				self,
				selector: #selector(updateTitle),
				name: event,
				object: nil)
		}
        
        
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(updateAll),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil)

	}

	@objc func updateTitle() {
        windowName = getWindowName()
        updateString()
	}
    
    @objc func updateAll() {
        windowName = getWindowName()
        desktopNumber = getDesktopNumber()
        updateString()
    }

    func updateString() {
        if let desktopNum = desktopNumber {
            self.stringValue = "\(desktopNum) \(windowName)"
        } else {
            self.stringValue = windowName
        }
    }
    
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    func getDesktopNumber() -> String? {
        let task = Process()
        task.launchPath = "/usr/local/bin/chunkc"
        task.arguments = ["tiling::query", "--desktop", "id"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
        } else {
            return nil
        }
    }
    
	func getWindowName() -> String {
		let trackScript = """
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell
"""
		var error: NSDictionary?
		if let scriptObject = NSAppleScript(source: trackScript) {
			let output = scriptObject.executeAndReturnError(&error)
			if error == nil {
				return output.stringValue ?? ""
			} else {
				print("error: \(String(describing: error))")
			}
		}
		return ""
	}
}


