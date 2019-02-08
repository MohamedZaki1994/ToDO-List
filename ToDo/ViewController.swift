//
//  ViewController.swift
//  ToDo List
//
//  Created by Mohamed Mahmoud Zaki on 7/11/18.
//  Copyright © 2018 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    
    var newViewController : firsstViewController?
    var searchViewController : searchViewController?
    var label : String?
     var managed : NSManagedObjectContext!
    var array :[Todos] = []
    
    
    
    @IBAction func Add(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        newViewController = storyBoard.instantiateViewController(withIdentifier: "firsstViewController") as? firsstViewController
        self.navigationController?.pushViewController(newViewController!, animated: true)
        self.tableview.reloadData()
    }
    
    @IBAction func search(_ sender: Any) {
        let stroyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        searchViewController = stroyboard.instantiateViewController(withIdentifier: "searchViewController") as? searchViewController
        self.navigationController?.pushViewController(searchViewController!, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.backgroundColor = UIColor.orange
        cell.textLabel?.text = array[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let act = UIContextualAction(style: .normal, title: "Ok") { (action, view, compl) in
            compl(true)
        }
        act.backgroundColor = .green
        
        
        return UISwipeActionsConfiguration(actions: [act])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Remove") { (action, view, completion) in
            // delete
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedcont = appDel.persistentContainer.viewContext
            let ar = self.array[indexPath.row]
            managedcont.delete(ar)
            do{
            try managedcont.save()
                self.array = try managedcont.fetch(Todos.fetchRequest())

            }
            catch{
                
            }
            
            self.tableview.reloadData()
            completion(true)
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableview.layer.borderWidth = 0
        tableview.layer.borderColor = UIColor.clear.cgColor
    
        self.navigationController?.toolbar.layer.borderColor = UIColor.clear.cgColor
        
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //fetch
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
       do {
            array = try context.fetch(Todos.fetchRequest())
        }
        catch{
            print("error")
        }
        self.tableview.reloadData()
    }
    
}

