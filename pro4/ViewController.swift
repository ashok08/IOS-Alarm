//
//  ViewController.swift
//  pro4
//
//  Created by Intern on 16/06/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    var data = [Alarm]()
    var display1: String?
    let timeFormatter = DateFormatter()
    @IBAction func timePickeraChange(_ sender: Any) {
        setDateAndTime()
        
    }
    override func viewDidLoad() {
         timePicker.backgroundColor = UIColor.lightGray
    }
    func setDateAndTime() {
     
        timeFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        display1 =  timeFormatter.string(from: timePicker.date)
       
    }
    
    
    @IBAction func save(_ sender: UIButton) {
       // ================================================
      //      var array: [String]? = []
     //      let val = display?.text
    //      var store = UserDefaults.standard.object(forKey: "time") as? [String]
   //      if store?.isEmpty == false{
  //         store?.append(val!)
  //         UserDefaults.standard.set(store, forKey: "time")
  //    }
  //    else{
  //        array?.append(val!)
  //       UserDefaults.standard.set(array, forKey: "time")
  //   }
  //==============================================
        
        
        insertData()
        
        self.dismiss( animated: false, completion: nil)
    }
    
  //MARK -insert to core
    
    
    func insertData()
    {
        var dateArray = [Date]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let datObj = dateFormatter.date(from: display1!)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if let alarmObj = NSEntityDescription.insertNewObject(forEntityName: "Alarm", into: context) as? Alarm {
            if data.isEmpty == true {
                dateArray.append(datObj!)
                print(dateArray)
                alarmObj.time = dateArray as NSObject
            }
        }
        appDelegate.saveContext()
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss( animated: false, completion: nil)
    }
}

