//
//  BatteryViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa
import IOKit.ps

struct BatteryInfo {
    var charging: Bool
    var percent: Int?
}

let NORMAL_COLOR: NSColor = NSColor(red: 0.71, green: 0.54, blue: 0.00, alpha: 1.0)
let CHARGING_COLOR: NSColor = NSColor(red: 0.52, green: 0.60, blue: 0.00, alpha: 1.0)

func powerSourceChanged(context: UnsafeMutableRawPointer?) {
    let opaque = Unmanaged<BatteryViewController>.fromOpaque(context!)
    // let _self = opaque.takeRetainedValue()
    let _self = opaque.takeUnretainedValue()
    _self.updateStatus()
}

class BatteryViewController: NSTextField, Component {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        usesSingleLineMode = true
        updateStatus()
        font = NSFont(name: "Hack", size: 12)
        backgroundColor = .clear
        isBezeled = false
        drawsBackground = false
        isSelectable = false
        isEditable = false
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.updateStatus()
        }

        // TODO: Why so much cpu?
//        let opaque = Unmanaged.passUnretained(self).toOpaque()
//        let loop: CFRunLoopSource = IOPSNotificationCreateRunLoopSource(
//            powerSourceChanged,
//            opaque
//        ).takeRetainedValue() as CFRunLoopSource
//        CFRunLoopAddSource(CFRunLoopGetCurrent(), loop, CFRunLoopMode.defaultMode)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateStatus() {
        let status = getStatus()

        if let perc = status.percent {
            stringValue = String(perc) + "%"
        } else {
            stringValue = "ERR"
        }

        if status.charging {
            textColor = CHARGING_COLOR
        } else {
            textColor = NORMAL_COLOR
        }
    }

    func getStatus() -> BatteryInfo {
        let psInfo = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let psInfoArray = (psInfo as! [[String: Any]])[0]

        return BatteryInfo(
            charging: psInfoArray["Power Source State"] as? String ?? "" == "AC Power",
            percent: psInfoArray["Current Capacity"] as? Int
        )
    }
}
