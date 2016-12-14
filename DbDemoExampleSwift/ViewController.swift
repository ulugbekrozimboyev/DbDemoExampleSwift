//
//  ViewController.swift
//  DbDemoExampleSwift
//
//  Created by Ulugbek on 12/14/16.
//  Copyright © 2016 Ulugbek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isEdit:Bool = false
    
    var studentData:Student? = nil
    
    
    @IBOutlet weak var txtName: UITextField!

    @IBOutlet weak var txtMarks: UITextField!
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        if !isEdit {
            let studentInfo: Student = Student()
            studentInfo.Name = txtName.text!
            studentInfo.Marks = txtMarks.text!
            let isInserted = ModelManager.sharedInstance.addStudentData(studentInfo: studentInfo)
            if isInserted {
            
                let alert = UIAlertController(title: "Alert", message: "Record Inserted successfully.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            } else {
                let alert = UIAlertController(title: "Alert", message: "Error in inserting record.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            }
        } else {
            let studentInfo: Student = Student()
            studentInfo.RollNo = (studentData?.RollNo)!
            studentInfo.Name = txtName.text!
            studentInfo.Marks = txtMarks.text!
            let isUpdated = ModelManager.sharedInstance.updateStudentData(studentInfo: studentInfo)
            if isUpdated {
                //Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                let alert = UIAlertController(title: "Alert", message: "Record updated successfully.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                //Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                let alert = UIAlertController(title: "Alert", message: "Error in updating record.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "MainView") as! StudentTableViewController
            self.present(viewController, animated:true, completion:nil)
            
        }
       
    }
    
    @IBOutlet weak var btnSaveClicked: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if isEdit {
            txtName.text = self.studentData?.Name
            txtMarks.text = self.studentData?.Marks
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

