//
//  ModelManager.swift
//  DbDemoExampleSwift
//
//  Created by Ulugbek on 12/14/16.
//  Copyright © 2016 Ulugbek. All rights reserved.
//

import Foundation

class ModelManager {

    static let sharedInstance = ModelManager()
    
    private var database: FMDatabase? = nil
    
    //privete init method to singleton
    private init(){
        
        if self.database == nil {
             self.database = FMDatabase(path: Utility.getPath(fileName: "Student.sqlite"))
        }
    }
    
    // test connection
    func testConnection() -> Bool {
        if self.database != nil {
            print("database yaratilgan")
            self.database?.open()
            if (self.database?.goodConnection())! {
                print("good connection")
                return true
            } else {
                print("connection is bad")
                return false
            }
            self.database?.close()
            
        } else {
            print("database yaratilmagan")
            return false
        }
    }
    // test create table
    func testCreateTable() -> Bool
    {
        self.database!.open()
        let isCreated = self.database!.executeUpdate("CREATE TABLE 'student_info' ('RollNo' INTEGER PRIMARY KEY autoincrement , 'Name' TEXT, 'Marks' INTEGER)", withArgumentsIn: nil)
        self.database!.close()
        return isCreated
    }
    
    // test is table exist
    func isExist(tableName name: String) -> Bool {
        self.database!.open()
        let table = self.database!.executeQuery("SELECT name FROM sqlite_master WHERE type='table' AND name=?;", withArgumentsIn: [name])
        self.database!.close()
        if table != nil {
            return true
        }
        return false
    }
    
    func addStudentData(studentInfo: Student) -> Bool
    {
        self.database!.open()
        let isInserted = self.database!.executeUpdate("INSERT INTO student_info (Name, Marks) VALUES (?, ?)", withArgumentsIn: [studentInfo.Name, studentInfo.Marks])
        self.database!.close()
        return isInserted
    }
    
    func getAllStudentData() -> NSMutableArray {
        self.database!.open()
        let resultSet: FMResultSet! = self.database!.executeQuery("SELECT * FROM student_info", withArgumentsIn: nil)
        let marrStudentInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let studentInfo : Student = Student()
                studentInfo.RollNo = resultSet.string(forColumn: "RollNo")
                studentInfo.Name = resultSet.string(forColumn: "Name")
                studentInfo.Marks = resultSet.string(forColumn: "Marks")
                marrStudentInfo.add(studentInfo)
            }
        }
        self.database!.close()
        return marrStudentInfo
    }
    
    func updateStudentData(studentInfo: Student) -> Bool {
        self.database!.open()
        let isUpdated = self.database!.executeUpdate("UPDATE student_info SET Name=?, Marks=? WHERE RollNo=?", withArgumentsIn: [studentInfo.Name, studentInfo.Marks, studentInfo.RollNo])
        self.database!.close()
        return isUpdated
    }
    
    func deleteStudentData(studentInfo: Student) -> Bool {
        self.database!.open()
        let isDeleted = self.database!.executeUpdate("DELETE FROM student_info WHERE RollNo=?", withArgumentsIn: [studentInfo.RollNo])
        self.database!.close()
        return isDeleted
    }
    
}
