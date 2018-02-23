//
//  Shell.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Foundation

func shell(launchPath: String, arguments: [String]) -> String {
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
