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
    
    private var database:FMDatabase
    
    //privete init method to singleton
    private init(){
        
        if(self.database == nil)
        {
             self.database = FMDatabase(path: Utility.getPath("Student.sqlite"))
        }
    }
    
}
