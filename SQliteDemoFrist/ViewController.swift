//
//  ViewController.swift
//  SQliteDemoFrist
//
//  Created by Macintosh on 02/01/24.
//

import UIKit

class ViewController: UIViewController {
    var employees : [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       var dbHelper =  DBHelper()
        
        dbHelper.insertAnEmployeeRecord(empId: 11, empName: "gajanan")
//        dbHelper.insertAnEmployeeRecord(empId: 11, empName: "ashitosh")
//        dbHelper.insertAnEmployeeRecord(empId: 11, empName: "rutik")
        print(" -------------- ")
        
        employees = dbHelper.retriveEmployeeRecords()
        for eachEmployee in employees{
            print("\(eachEmployee.empId)---\(eachEmployee.empName)")
            
        }
        print("--------------")
        
        dbHelper.deleteAnEmployeeRecord(empId: 13)
        
        print("----------")
        
        employees =  dbHelper.retriveEmployeeRecords()
        for eachEmployee in employees{
            print("\(eachEmployee.empId)----\(eachEmployee.empName)")
        }
    }


}

