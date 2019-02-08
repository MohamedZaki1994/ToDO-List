//
//  firsstViewController.swift
//  ToDo
//
//  Created by Mohamed Mahmoud Zaki on 7/11/18.
//  Copyright © 2018 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData
class firsstViewController: UIViewController {

   var manage = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var txt : String?
    @IBOutlet weak var textBotConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var txtfield: UITextField!
    @IBOutlet weak var label: UILabel!
    var newViewController: ViewController?
    var array : [Todos]?
    
    @IBAction func Done(_ sender: Any) {
      //insert
        if let tf = self.txtfield.text , !tf.isEmpty {
         //   let tod = NSEntityDescription.insertNewObject(forEntityName: "Todos", into: manage)
       let tod = Todos(context: manage)
            tod.setValue(tf, forKey: "title")
            do {
                try manage.save()
            }
            catch{
                print("error")
            }
     
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         newViewController = storyBoard.instantiateViewController(withIdentifier: "tableview") as! ViewController
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        txtfield.becomeFirstResponder()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
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
