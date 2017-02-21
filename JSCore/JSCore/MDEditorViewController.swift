//
//  MDEditorViewController.swift
//  JSCore
//
//  Created by Gabriel Theodoropoulos on 13/02/17.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import UIKit

class MDEditorViewController: UIViewController {

    @IBOutlet weak var tvEditor: UITextView!
    
    @IBOutlet weak var webResults: UIWebView!
    
    @IBOutlet weak var conTrailingEditor: NSLayoutConstraint!
    
    @IBOutlet weak var conLeadingWebview: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    // MARK: IBAction Methods
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func previewHTML(_ sender: Any) {
        var newTrailingConstant: CGFloat!
        
        if conTrailingEditor.constant == 0.0 {
            newTrailingConstant = self.view.frame.size.width/2
        }
        else if conTrailingEditor.constant == self.view.frame.size.width/2 {
            newTrailingConstant = self.view.frame.size.width
        }
        else {
            newTrailingConstant = 0.0
        }
        
        
        UIView.animate(withDuration: 0.4) {
            self.conTrailingEditor.constant = newTrailingConstant
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func convert(_ sender: Any) {
        
    }
    
    

}
