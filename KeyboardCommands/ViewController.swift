//
//  ViewController.swift
//  KeyboardCommands
//
//  Created by Brandon Alexander on 9/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import UIKit

@objc protocol KeyCommandReceiver: class {
    func aKeyPressed(sender: AnyObject?)
}

class ViewController: UIViewController {

    @IBOutlet weak var customTextView: CustomTextView!

    @IBAction func textViewTapped(_ sender: AnyObject) {
        customTextView.becomeFirstResponder()
    }
}

extension ViewController: KeyCommandReceiver {
    func aKeyPressed(sender: AnyObject?) {
        customTextView.render(text: "a")
    }
}


class CustomTextView: UIView {
    private var textToRender: NSString? {
        didSet {
            setNeedsDisplay()
        }
    }

    func render(text: NSString) {
        textToRender = text
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        textToRender?.draw(at: .zero, withAttributes: nil)
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var canResignFirstResponder: Bool {
        return true
    }

    override var keyCommands: [UIKeyCommand]? {
        var array = [UIKeyCommand]()

        let keyCommand = UIKeyCommand(input: "a", modifierFlags: [], action: #selector(KeyCommandReceiver.aKeyPressed(sender:)))
        
        array.append(keyCommand)
        return array
    }
}
