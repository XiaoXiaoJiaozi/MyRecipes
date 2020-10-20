//
//  ViewController.swift
//  MyRecipes
//
//  Created by Lucy on 10/19/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var servings: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var steps: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnEdit(_ sender: UIButton) {
        //0a Edit contact
                name.isEnabled = true
                servings.isEnabled = true
                ingredients.isEnabled = true
                steps.isEnabled = true
                btnSave.isHidden = false
                btnEdit.isHidden = true
                name.becomeFirstResponder()
                
                //**End Copy**
    }
    
    
    @IBAction func btnSave(_ sender: AnyObject) {
        //1 Add Save Logic
                
                
                if (recipedb != nil)
                {
                    
                    recipedb.setValue(name.text, forKey: "name")
                    recipedb.setValue(servings.text, forKey: "servings")
                    recipedb.setValue(ingredients.text, forKey: "ingredients")
                    recipedb.setValue(steps.text, forKey: "steps")
                    
                }
                else
                {
                    let entityDescription =
                        NSEntityDescription.entity(forEntityName: "Recipe",in: managedObjectContext)
                    
                    let recipe = Recipe(entity: entityDescription!,
                                          insertInto: managedObjectContext)
                    
                    recipe.name = name.text!
                    recipe.servings = servings.text!
                    recipe.ingredients = ingredients.text!
                    recipe.steps = steps.text!
                }
                var error: NSError?
                do {
                    try managedObjectContext.save()
                } catch let error1 as NSError {
                    error = error1
                }
                
                if let err = error {
                    //if error occurs
                   // status.text = err.localizedFailureReason
                } else {
                    self.dismiss(animated: false, completion: nil)
                    
                }
                //**End Copy**
    }
    
    

    
    @IBAction func btnBack(_ sender: AnyObject) {
        //**Begin Copy**
               //2) Dismiss ViewController
              self.dismiss(animated: true, completion: nil)
       //       let detailVC = RecipeTableViewController()
       //        detailVC.modalPresentationStyle = .fullScreen
       //        present(detailVC, animated: false)
               //**End Copy**
    }
    
    //**Begin Copy**
        //3) Add ManagedObject Data Context
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //**End Copy**
        
        
        //**Begin Copy**
        //4) Add variable recipedb (used from UITableView
        var recipedb:NSManagedObject!
        //**End Copy**
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //**Begin Copy**
            //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
            
            
            if (recipedb != nil)
            {
                name.text = recipedb.value(forKey: "name") as? String
                servings.text = recipedb.value(forKey: "servings") as? String
                ingredients.text = recipedb.value(forKey: "ingredients") as? String
                steps.text = recipedb.value(forKey: "steps") as? String
                btnSave.setTitle("Update", for: UIControl.State())
               
                btnEdit.isHidden = false
                name.isEnabled = false
                servings.isEnabled = false
                ingredients.isEnabled = false
                steps.isEnabled = false
                btnSave.isHidden = true
            }else{
              
                btnEdit.isHidden = true
                name.isEnabled = true
                servings.isEnabled = true
                ingredients.isEnabled = true
                steps.isEnabled = true
            }
            name.becomeFirstResponder()
            // Do any additional setup after loading the view.
            //Looks for single or multiple taps
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
            //Adds tap gesture to view
            view.addGestureRecognizer(tap)
            
            
            // Do any additional setup after loading the view, typically from a nib.
            
            //**End Copy**
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        //**Begin Copy**
        //6 Add to hide keyboard
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches , with:event)
            if (touches.first as UITouch?) != nil {
                DismissKeyboard()
            }
        }
        //**End Copy**
        
        
        //**Begin Copy**
        //7 Add to hide keyboard
        
        @objc func DismissKeyboard(){
            //forces resign first responder and hides keyboard
            name.endEditing(true)
            servings.endEditing(true)
            ingredients.endEditing(true)
            steps.endEditing(true)
            
        }
        //**End Copy**
        
        //**Begin Copy**
        
        //8 Add to hide keyboard
        
        func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
            textField.resignFirstResponder()
            return true;
        }
        //**End Copy**
    }


    
    

