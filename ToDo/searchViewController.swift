//
//  searchViewController.swift
//  ToDo
//
//  Created by Mohamed Mahmoud Zaki on 7/18/18.
//  Copyright © 2018 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import CoreData
class searchViewController: UIViewController {

    @IBOutlet weak var searchTxt: UITextField!
    
    @IBOutlet weak var results: UILabel!
    
    @IBAction func searchBtn(_ sender: Any) {
        let search = self.searchTxt.text
        var temp = ""
        self.results.text = temp

        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedcont = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", search!)

        do {
           let result = try managedcont.fetch(request)
            if result.count > 0 {
                for obj in result{
                    let oneTitle = (obj as AnyObject).value(forKey: "title") as! String
                    temp += oneTitle + "\n"
                }
               self.results.text = temp
            }
            else {
                self.results.text = "match not found"
            }
        }
        catch{
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
