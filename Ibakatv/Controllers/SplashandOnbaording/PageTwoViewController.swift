//
//  PageTwoViewController.swift
//  Ibakatv
//
//  Created by Nwudo Ebuka on 5/26/19.
//  Copyright © 2019 Nwudo Ebuka. All rights reserved.
//

import UIKit

class PageTwoViewController: UIViewController {
    @IBOutlet var secondElementLabel: UILabel!
    @IBOutlet var secondElementTextField: UITextField!
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var firstElementLabel: UILabel!
    var isOn = Bool()
    @IBAction func firstElementSwitch(_ sender: Any) {
        if isOn{
            secondElementLabel.isHidden = true
            secondElementTextField.isHidden = true
            isOn = false
        }else{
            secondElementLabel.isHidden = false
            secondElementTextField.isHidden = false
            isOn = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        
    }
    
    func setLabels(){
        
        pageLabel.text = getJSON("testJson")["pages"][1]["label"].stringValue
        sectionLabel.text = getJSON("testJson")["pages"][1]["sections"][0]["label"].stringValue
        firstElementLabel.text = getJSON("testJson")["pages"][1]["sections"][0]["elements"][0]["label"].stringValue
        secondElementLabel.text = getJSON("testJson")["pages"][1]["sections"][0]["elements"][1]["label"].stringValue
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        PageThreeViewController.page2Element1 = secondElementTextField.text!
        PageThreeViewController.page2Element0 = isOn
    }
  
}
