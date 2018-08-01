//
//  SpotifyViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class SpotifyViewController : NSTextField, Component {
    var songName: String?
    var artistName: String?
    var hovering = false
    var trackingArea: NSTrackingArea?
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
        (songName, artistName) = getSpotify()
        self.usesSingleLineMode = true
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.86, green: 0.20, blue: 0.18, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            (self.songName, self.artistName) = self.getSpotify()
            self.updateField()
 		}
        updateField()

		let center = DistributedNotificationCenter.default()
		center.addObserver(self, selector: #selector(updateField), name: NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged"), object: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    @objc func updateField() {
        if hovering {
            self.stringValue = artistName ?? ""
        } else {
            self.stringValue = songName ?? ""
        }
    }

	func getSpotify() -> (String?, String?) {
		let trackScript = """
if application "Spotify" is running then
	tell application "Spotify"
		return name of current track as string & "\n" & artist of current track as string
	end tell
end if
"""
		var error: NSDictionary?
		if let scriptObject = NSAppleScript(source: trackScript) {
			let output = scriptObject.executeAndReturnError(&error)
			if error == nil {
                if let str = output.stringValue {
                    let split = str.components(separatedBy: "\n")
                    return (split[0], split[1])
                }
			} else {
				print("error: \(String(describing: error))")
			}
		}
		return (nil, nil)
	}
    
    override func mouseEntered(with event: NSEvent) {
        self.hovering = true
        updateField()
    }
    
    override func mouseExited(with event: NSEvent) {
        self.hovering = false
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateField), userInfo: nil, repeats: false)
    }
    
    func viewDidAppear() {
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let area = trackingArea {
            self.removeTrackingArea(area)
        }
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
}
