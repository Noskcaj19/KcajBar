//
//  Wifi.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Foundation
import CoreWLAN

enum WifiStatus {
	case off
	case on(String)
}

private func shell(launchPath: String, arguments: [String]) -> String {
	let task = Process()
	task.launchPath = launchPath
	task.arguments = arguments

	let pipe = Pipe()
	task.standardOutput = pipe
	task.launch()

	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	let output = String(data: data, encoding: String.Encoding.utf8)!
	if output.count > 0 {
		// remove newline character.
		let lastIndex = output.index(before: output.endIndex)
		return String(output[output.startIndex ..< lastIndex])
	}
	return output
}

private func getNetworkName() -> Optional<String> {
	return CWWiFiClient.shared().interface()?.ssid()

}

func wifiStatus() -> WifiStatus {
	let command = shell(launchPath: "/usr/sbin/networksetup", arguments: ["-getairportpower", "en0"])
	if let status = command.split(separator: " ").last {
		if status == "On" {
			if let wifiNetwork = getNetworkName() {
				return .on(wifiNetwork)
			}
		}
	}
	return .off
}
