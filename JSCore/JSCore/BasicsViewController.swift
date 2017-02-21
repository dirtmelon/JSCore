//
//  BasicsViewController.swift
//  JSCore
//
//  Created by Gabriel Theodoropoulos on 13/02/17.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import UIKit
import JavaScriptCore

class BasicsViewController: UIViewController {
	
	var jsContext: JSContext!
	var guessedNumbers = [5, 37, 22, 18, 9, 42]
	
	let luckyNumbersHandler: @convention(block) ([Int]) -> Void = { luckyNumbers in
		NotificationCenter.default.post(name: Notification.Name("didReceiveRandomNumbers"), object: luckyNumbers)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		NotificationCenter.default.addObserver(self,
			selector: #selector(BasicsViewController.handleDidReceiveLuckyNumbersNotification(notification:)),
			name: Notification.Name("didReceiveRandomNumbers"), object: nil)
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		initializeJS()
		helloWorld()
		jsDemo1()
		jsDemo2()
		jsDemo3()
	}
	
	func initializeJS() {
		jsContext = JSContext()
		jsContext.exceptionHandler = { context, exception in
			if let exc = exception {
				print("JS Exception:", exc.toString())
			}
		}
		
		if let jsSourcePath = Bundle.main.path(forResource: "jssource", ofType: "js") {
			do {
				let jsSourceContents = try String(contentsOfFile: jsSourcePath)
				jsContext.evaluateScript(jsSourceContents)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}
	
	func helloWorld() {
		if let variableHelloWorld = jsContext.objectForKeyedSubscript("helloWorld") {
			print(variableHelloWorld.toString())
		}
	}
	
	func jsDemo1() {
		let firstname = "Mickey"
		let lastname = "Mouse"
		
		if let functionFullname = jsContext.objectForKeyedSubscript("getFullname") {
			if let fullname = functionFullname.call(withArguments: [firstname, lastname]) {
				print(fullname.toString())
			}
		}
	}
	
	func jsDemo2() {
		let values = [10, -5, 22, 14, -35, 101, -55, 16, 14]
		
		if let functionMaxMinAverage = jsContext.objectForKeyedSubscript("maxMinAverage") {
			if let results = functionMaxMinAverage.call(withArguments: [values]) {
				if let resultsDict = results.toDictionary() {
					for (key, value) in resultsDict {
						print(key, value)
					}
				}
			}
		}
	}
	
	func jsDemo3() {
		let luckyNumbersObject = unsafeBitCast(luckyNumbersHandler, to: AnyObject.self)
		jsContext.setObject(luckyNumbersObject, forKeyedSubscript: "handleLuckyNumbers" as (NSCopying & NSObjectProtocol)!)
		_ = jsContext.evaluateScript("handleLuckyNumbers")
		
		if let functionGenerateLuckyNumbers = jsContext.objectForKeyedSubscript("generateLuckyNumbers") {
			_ = functionGenerateLuckyNumbers.call(withArguments: nil)
		}
	}
	
	func handleDidReceiveLuckyNumbersNotification(notification: Notification) {
		if let luckyNumbers = notification.object as? [Int] {
			print("\n\nLucky numbers:", luckyNumbers, " Your guess:", guessedNumbers, "\n")
			
			var correctGuesses = 0
			for number in luckyNumbers {
				if let _ = guessedNumbers.index(of: number) {
					print("You guessed correcyly:", number)
					correctGuesses += 1
				}
			}
			
			print("Total correct guesses:", correctGuesses)
			
			if correctGuesses == 6 {
				print("You are the big winner!!!")
			}
		}
	}
	
    // MARK: IBAction Method
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
