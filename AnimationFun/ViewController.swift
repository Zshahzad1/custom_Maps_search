//
//  ViewController.swift
//  AnimationFun
//
//  Created by user user on 27/08/2018.
//  Copyright © 2018 Believerz. All rights reserved.
//

import UIKit
import SlackTextViewController

class ViewController: SLKTextViewController{
    var textiew = SLKTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textiew.placeholder = "Write here..."
        textiew.delegate = self
        self.registerPrefixes(forAutoCompletion: ["@", "#"])
        self.view.addSubview(textiew)
        textiew.center = view.center
    }


}

