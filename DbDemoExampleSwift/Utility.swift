//
//  Utility.swift
//  DbDemoExampleSwift
//
//  Created by Ulugbek on 12/14/16.
//  Copyright © 2016 Ulugbek. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
//    let alert:UIAlertController
    
    class func getPath(fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    class func copyFile(fileName: NSString) -> String {
        
        var result:String = ""
        
        let dbPath: String = getPath(fileName: fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
            
            if (error != nil) {
                alert.title = "Error Occured"
                alert.message = error?.localizedDescription
                print("error while copy file")
                result = "error while copy file"
            } else {
                alert.title = "Successfully Copy"
                alert.message = "Your database copy successfully"
                print("file was copied successfully")
                result = "file was copied successfully"
            }
            
        } else {
            result = "File does not exist"
        }
        
        return result
    }
    
}
