//
//  StudentTableViewController.swift
//  DbDemoExampleSwift
//
//  Created by Ulugbek on 12/14/16.
//  Copyright © 2016 Ulugbek. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    var marrStudentData: NSMutableArray = NSMutableArray(){
        didSet {
            self.tbStudentData.reloadData()
        }
    }
    
    @IBOutlet var tbStudentData: UITableView!

    @IBAction func btnEditClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "editSegue", sender: sender)
    }
    
    @IBAction func btnDeleteClicked(_ sender: Any) {
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        let studentInfo: Student = marrStudentData.object(at: selectedIndex) as! Student
        let isDeleted = ModelManager.sharedInstance.deleteStudentData(studentInfo: studentInfo)
        if isDeleted {
            //Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
            print("Record deleted")
        } else {
            //Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            print("Error in deleting record.")
        }
        self.getStudentData()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStudentData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return marrStudentData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentTableViewCell
        
        let student:Student = marrStudentData.object(at: indexPath.row) as! Student
        cell.lblContent.text = "Name : \(student.Name) \n Marks : \(student.Marks)"
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row

        return cell
    }
    
    func getStudentData() {
        self.marrStudentData = ModelManager.sharedInstance.getAllStudentData()
    }
    
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if(identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let viewController = storyBoard.instantiateViewController(withIdentifier: "insert") as! ViewController
            
            viewController.isEdit = true
            viewController.studentData = marrStudentData.object(at: selectedIndex) as! Student
            
            self.present(viewController, animated:true, completion:nil)
            
        }

    }

}
