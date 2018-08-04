//
//  SpotifyViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class SpotifyViewController: NSTextField, Component {
    var songName: String?
    var artistName: String?
    var hovering = false
    var trackingArea: NSTrackingArea?
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        usesSingleLineMode = true
        font = NSFont(name: "Hack", size: 12)
        textColor = NSColor(red: 0.86, green: 0.20, blue: 0.18, alpha: 1.0)
        backgroundColor = .clear
        isBezeled = false
        drawsBackground = false
        isSelectable = false
        isEditable = false
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.updateAll()
        }
        updateAll()

        let center = DistributedNotificationCenter.default()
        center.addObserver(self, selector: #selector(updateAll), name: NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged"), object: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func updateAll() {
        (songName, artistName) = getSpotify()
        updateField()
    }

    @objc func updateField() {
        (songName, artistName) = getSpotify()
        if hovering {
            stringValue = artistName ?? ""
        } else {
            stringValue = songName ?? ""
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

    override func mouseEntered(with _: NSEvent) {
        hovering = true
        updateField()
    }

    override func mouseExited(with _: NSEvent) {
        hovering = false
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateField), userInfo: nil, repeats: false)
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
