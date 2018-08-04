//
//  TimeViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class TimeViewController: NSTextField, Component {
    let dateFormatter = DateFormatter()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        dateFormatter.dateFormat = "hh:mm"
        usesSingleLineMode = true
        stringValue = getTime()
        font = NSFont(name: "Hack", size: 12)
        textColor = NSColor(red: 0.52, green: 0.60, blue: 0.00, alpha: 1.0)
        backgroundColor = .clear
        isBezeled = false
        drawsBackground = false
        isSelectable = false
        isEditable = false
        alignment = .right
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.stringValue = self.getTime()
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getTime() -> String {
        let date = Date()
        return dateFormatter.string(from: date)
    }
}
