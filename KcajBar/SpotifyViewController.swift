//
//  SpotifyViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class SpotifyViewController : NSTextField, Component {
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.stringValue = getSpotify()
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.86, green: 0.20, blue: 0.18, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
			self.stringValue = self.getSpotify()
		}

		let center = DistributedNotificationCenter.default()
		center.addObserver(self, selector: #selector(handleSongChange), name: NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged"), object: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func handleSongChange() {
		self.stringValue = self.getSpotify()
	}

	func getSpotify() -> String {
		let trackScript = """
if application "Spotify" is running then
	tell application "Spotify"
		return name of current track as string
	end tell
end if
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
