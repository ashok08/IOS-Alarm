//
//  ViewController1.swift
//  pro4
//
//  Created by Intern on 19/06/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
      let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
         CreateDatePicker()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var datepi: UIDatePicker!
func CreateDatePicker()
{
    datePicker.datePickerMode = .date
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        let dp = datePicker.date
        print("\(dp)")
        
    }
    

   }
