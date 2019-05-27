//
//  PageThreeViewController.swift
//  Ibakatv
//
//  Created by Nwudo Ebuka on 5/26/19.
//  Copyright © 2019 Nwudo Ebuka. All rights reserved.
//

import UIKit
import SwiftyJSON

class PageThreeViewController: UIViewController {
        var sb:Snackbar? =  nil
    @IBAction func submitAction(_ sender: Any) {
        
        if checkRules(){
             showMessage("Input validated Succesfully!")
        }
        
        
    }
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var firstelementLabel: UILabel!
    @IBOutlet var firstelementTextField: UITextField!
    @IBOutlet var secondElementLabel: UILabel!
    @IBOutlet var secondElementTextField: UITextField!
    static var page1Element1 = String()
    static var page1Element2 = String()
    static var page1Element3 = String()
    static var page2Element0 = Bool()
    static var page2Element1 = String()
    static var page1Element4 = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
  
    }
    
    func setLabels(){
        
        pageLabel.text = getJSON("testJson")["pages"][2]["label"].stringValue
        sectionLabel.text = getJSON("testJson")["pages"][2]["sections"][0]["label"].stringValue
        firstelementLabel.text = getJSON("testJson")["pages"][2]["sections"][0]["elements"][0]["label"].stringValue
        secondElementLabel.text = getJSON("testJson")["pages"][2]["sections"][0]["elements"][1]["label"].stringValue
    }
    
    
    func showMessage(_ message:String){
        if(sb == nil){
            sb = Snackbar()
        }
        
        sb?.createWithAction(text: message, actionTitle: "Ok", action: {
            self.sb?.hide();
        })
    }

    
    func checkRules()->Bool {
        
        if getJSON("testJson")["pages"][0]["sections"][1]["elements"][0]["isMandatory"].boolValue && PageThreeViewController.page1Element1.isEmpty{
            showMessage("some fields are required on page one!")
            return false
        }
        if getJSON("testJson")["pages"][0]["sections"][1]["elements"][1]["isMandatory"].boolValue && PageThreeViewController.page1Element2.isEmpty{
            showMessage("some fields are required on page one!")
            return false
        }
        if getJSON("testJson")["pages"][0]["sections"][1]["elements"][2]["isMandatory"].boolValue && PageThreeViewController.page1Element3.isEmpty{
            showMessage("some fields are required on page one!")
            return false
        }
        if getJSON("testJson")["pages"][0]["sections"][1]["elements"][3]["isMandatory"].boolValue && PageThreeViewController.page1Element4.isEmpty{
            showMessage("some fields are required on page one!")
            return false
        }
   
        if getJSON("testJson")["pages"][1]["sections"][0]["elements"][1]["isMandatory"].boolValue && PageThreeViewController.page2Element1.isEmpty{
            showMessage("some fields are required on page Two!")
            return false
        }
        
        if getJSON("testJson")["pages"][2]["sections"][0]["elements"][0]["isMandatory"].boolValue && firstelementTextField.text!.isEmpty{
              showMessage("some fields are required on this page!")
            return false
        }
        if getJSON("testJson")["pages"][2]["sections"][0]["elements"][1]["isMandatory"].boolValue && secondElementTextField.text!.isEmpty{
            showMessage("some fields are required on this page!")
            return false
        }
     
        return true
    }
}
