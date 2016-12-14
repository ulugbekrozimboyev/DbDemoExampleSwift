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
       
    }
    
    @IBOutlet weak var btnSaveClicked: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

