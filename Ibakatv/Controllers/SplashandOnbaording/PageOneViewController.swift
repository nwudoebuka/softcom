//
//  PageOneViewController.swift
//  Ibakatv
//
//  Created by Nwudo Ebuka on 5/25/19.
//  Copyright © 2019 Nwudo Ebuka. All rights reserved.
//

import UIKit
import SwiftyJSON
class PageOneViewController: UIViewController {
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var infoLabelHead: UILabel!
    @IBOutlet var infoLabel1: UILabel!
    @IBOutlet var infoLabel2: UILabel!
    @IBOutlet var infoLabel3: UILabel!
    @IBOutlet var infoLabel4: UILabel!
    private var datepicker: UIDatePicker?
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var textfield3: UITextField!
    @IBOutlet var textfield4: UITextField!
    var datTxt = UITextField()
    var textFieldArray:[UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardToolBar()
        
        adjustOriginOnKeyboardShow(vc: PageOneViewController(), adjustmentHeight: 150)
        loading.startAnimating()
         textFieldArray = [textField1,textField2,textfield3,textfield4]
        setLabelsFromJson()
       let imgUrl = getJSON("testJson")["pages"][0]["sections"][0]["elements"][0]["file"].stringValue
        loadImageFromUrl(imgUrl)
    }
    
    func loadImageFromUrl(_ urlImg:String){
        let catPictureURL = URL(string: urlImg)!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            if let e = error {
              self.alert(msg: "Error downloading test picture: \(e)",stat: "failed")
            } else {
              
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        let urlImage = UIImage(data: imageData)
                         DispatchQueue.main.async {
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                        self.image.image = urlImage
                        }
              
                    } else {
                        print("Couldn't get image: Image is nil")
                        self.alert(msg: "Couldn't get image: Image is nil",stat: "failed")
                    }
                } else {
                   self.alert(msg: "Couldn't get response code for some reason",stat: "failed")
                }
            }
        }
        
        downloadPicTask.resume()
        
    }
    func setLabelsFromJson(){
        pageLabel.text = getJSON("testJson")["pages"][0]["label"].stringValue
        sectionLabel.text = getJSON("testJson")["pages"][0]["sections"][0]["label"].stringValue
        infoLabelHead.text = getJSON("testJson")["pages"][0]["sections"][1]["label"].stringValue
        infoLabel1.text = getJSON("testJson")["pages"][0]["sections"][1]["elements"][0]["label"].stringValue
         infoLabel2.text = getJSON("testJson")["pages"][0]["sections"][1]["elements"][1]["label"].stringValue
         infoLabel3.text = getJSON("testJson")["pages"][0]["sections"][1]["elements"][2]["label"].stringValue
         infoLabel4.text = getJSON("testJson")["pages"][0]["sections"][1]["elements"][3]["label"].stringValue
        
        setInputTypes()
        
    }
    func setInputTypes(){
      let numOfElements = getJSON("testJson")["pages"][0]["sections"][1]["elements"].count
        
        for i in 0...numOfElements - 1{
            
            let type = getJSON("testJson")["pages"][0]["sections"][1]["elements"][i]["type"].stringValue
            inputType(type,i)
        }
        
    }
    
    func inputType(_ str:String, _ index:Int){
        print(index)
        switch str {
        case "formattednumeric":
            textFieldArray[index].keyboardType = .numberPad
        case "datetime":
            datTxt = textFieldArray[index]
            datePickers(textFieldArray[index])
        default:
            print("is default")
        }
        
    }
    
    
    func datePickers(_ textFd:UITextField) {
       
        datepicker  =  UIDatePicker()
        datepicker?.datePickerMode = .date
        textFd.inputView = datepicker
        datepicker?.addTarget(self, action: #selector(PageOneViewController.dateChanged(datepicker:)), for: .valueChanged)
        datepicker?.backgroundColor = UIColor.white
        
        
       
        
        
    }
    
    @objc func dismiskey() {
        
        view.endEditing(true)
    }
    
    @objc func dateChanged(datepicker: UIDatePicker){
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        datTxt.text = dateformat.string(from: datepicker.date)
      view.endEditing(true)
   }
    
    func setKeyboardToolBar(){
    
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    
    //Customizations
    toolBar.barTintColor = UIColor.lightGray
    toolBar.tintColor = .white
    toolBar.backgroundColor = UIColor.lightGray
    toolBar.barTintColor = .white
    toolBar.tintColor = .blue
    
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PageOneViewController.dismiskey))
    
    toolBar.setItems([doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    
        textField1.inputAccessoryView = toolBar
        textField2.inputAccessoryView = toolBar
        textfield3.inputAccessoryView = toolBar
        textfield4.inputAccessoryView = toolBar
        
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        PageThreeViewController.page1Element1 = textField1.text!
        PageThreeViewController.page1Element2 = textField2.text!
        PageThreeViewController.page1Element3 = textfield3.text!
        PageThreeViewController.page1Element4 = textfield4.text!
    }
}
