//
//  DateViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class DateViewController: NSTextField, Component {
    var hovering = false
    var trackingArea: NSTrackingArea?
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        font = NSFont(name: "Hack", size: 12)
        textColor = NSColor(red: 0.15, green: 0.55, blue: 0.82, alpha: 1.0)
        backgroundColor = .clear
        isBezeled = false
        drawsBackground = false
        isSelectable = false
        isEditable = false
        Timer.scheduledTimer(withTimeInterval: 60 * 10, repeats: true) { _ in
            self.updateField()
        }
        updateField()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func updateField() {
        stringValue = getDate(short: hovering)
    }

    func getDate(short: Bool) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = short ? "MM/dd/yy" : "EEE dd MMM"
        return dateFormatter.string(from: date)
    }

    override func mouseEntered(with _: NSEvent) {
        hovering = true
        updateField()
    }

    override func mouseExited(with _: NSEvent) {
        hovering = false
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateField), userInfo: nil, repeats: false)
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
