//
//  ViewController.swift
//  HttpPod
//
//  Created by hcgharish on 08/21/2023.
//  Copyright (c) 2023 hcgharish. All rights reserved.
//

import UIKit
import HttpPod

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       let ob = Testing();
        ob.testing()
        
        Http.instance().request(<#T##par: HttpParams##HttpParams#>, completionHandler: <#T##(HttpResponse?) -> Void#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

