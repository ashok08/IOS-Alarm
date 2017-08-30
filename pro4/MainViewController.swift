//
//  MainViewController.swift
//  pro4
//
//  Created by Intern on 19/06/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var edit: UIButton!
    
    @IBAction func doEdit(_ sender: Any) {
        if (self.tableView.isEditing) {
            
            edit.setTitle("Edit", for: .normal )
            self.tableView.setEditing(false, animated: true)
        } else {
            edit.setTitle("Done", for: .normal)
            self.tableView.setEditing(true, animated: true)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var data = [Alarm]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("editButtonPressed")))
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        fetchdata()
        tableView.reloadData()
    }
    
    
    //MARK -FetchFromCore
    
    
    func fetchdata()
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Alarm")
        let sort = NSSortDescriptor(key: "time", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do
        {
            data = try context?.fetch(fetchRequest) as! [Alarm]
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //=============================================
        //      if let value = UserDefaults.standard.object(forKey: "time") as? [String]
        //      {
        //         return value.count
        //      }
        //=============================================
        return data.count
    }
    
    //MARK -EditCell
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //MARK -DeleteCell
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if let appDel:AppDelegate = UIApplication.shared.delegate as? AppDelegate{
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        context.delete(data[indexPath.row] as NSManagedObject)
        data.remove(at: indexPath.row)
        do
        {
            try context.save()

        }
        catch
        {
            
        }
        self.tableView.deleteRows(at: [indexPath], with: .fade)
       tableView.reloadData()
    }
    }
    
    var objID = NSManagedObjectID()
    
    //MARK -InsertingToCell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        //===================================================
        //   if UserDefaults.standard.string(forKey: "time") == nil {
        //   let time = UserDefaults.standard.object(forKey: "time") as? [String]
        // cell.label?.text = time?[indexPath.row]
        //===================================================
        
        let val = data[indexPath.row]
        if let val1 = val.value(forKey: "time") as? [Date]{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let dateObj = dateFormatter.string(from: val1[0]) as String
            cell.label?.text =  dateObj
            let switchview = UISwitch(frame: .zero)
            switchview.setOn(false, animated: true)
            if data[indexPath.row].status == true
            {
                switchview.setOn(true, animated: true)
            }
            else
            {
                switchview.setOn(false, animated: false)
            }
       
            switchview.tag = indexPath.row
            switchview.addTarget(self, action: #selector(MainViewController.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
            cell.accessoryView = switchview
        }
        
        return cell
    }
    
    
    func switchIsChanged(_ sender: UISwitch)
    {
        objID =   data[sender.tag].objectID
        if  let appDel:AppDelegate = UIApplication.shared.delegate as? AppDelegate
        {
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Alarm")
            fetchRequest.predicate = NSPredicate(format:"SELF = %@", objID)
            do
            {
                let arr = try context.fetch(fetchRequest) as! [Alarm]
                for ar in arr
                {
                    if sender.isOn
                    {
                        ar.setValue(true ,forKey: "status")
                    }
                    else
                    {
                        ar.setValue(false, forKey: "status")
                    }
                    do
                    {
                        try context.save()
                    }
                    catch let error as NSError
                    {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
                
            }
            catch
            {
                print("Could not save \(error)")
                
            }
        }
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


