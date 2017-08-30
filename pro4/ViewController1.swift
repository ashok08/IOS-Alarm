//
//  ViewController1.swift
//  pro4
//
//  Created by Intern on 19/06/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func save(_ sender: UIButton) {
 let dp = datePicker.date
        print("\(dp)")
}


}
