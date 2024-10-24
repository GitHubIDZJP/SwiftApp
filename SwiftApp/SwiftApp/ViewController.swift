//
//  ViewController.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person()
        person.name = "sdhjds"
        person.eat()
        
//        AF.request().requestCustomJSONEncodable(<#T##Encodable#>, encoder: <#T##JSONEncoder#>)
    }


}

