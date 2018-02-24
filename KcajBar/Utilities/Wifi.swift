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