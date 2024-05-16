//
//  DBHelper.swift
//  SQliteDemoFrist
//
//  Created by Macintosh on 02/01/24.
//

import Foundation
import SQLite3



class DBHelper{
var dbPath : String = "iOSjan.sqlite"
var db : OpaquePointer?
    
init(){
    db = self.openDatabase()
    
    
}
func  openDatabase()->OpaquePointer?
{
    let fileUrl = try! FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false).appendingPathExtension(dbPath)
    
    
    if sqlite3_open(
        fileUrl.path,&db) == SQLITE_FAIL{
        print("Database creation was not successful!")
    }
    
    else {
        print("File URL -- \(fileUrl.path)")
        print("Database is created successfully \(dbPath)")
        print("db -- \(String(describing: db))")
    }
    return db
}
    
    func createEployeeTable(){
        let createQueryString = "CREATE TABLE IF NOT EXISTS Employee(empId INTEGER, empName Text);"
        
        var createStatment : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              createQueryString,
                              -1,
                              &createStatment,
                              nil) == SQLITE_OK{
            
            if sqlite3_step(createStatment) == SQLITE_DONE{
            print("Employee Table created successfully")
                print(createStatment as Any)
                
            }
            else {
                print("Employee Table creation has failed")
            }
            
        }
            else{
                print("The queary statment preparation has failed ")
            }
        sqlite3_str_finish(createStatment)
        
        }
            
        func insertAnEmployeeRecord(empId : Int, empName : String){
            let insertQueryString = "INSERT INTO Employee(empId, empName) VALUES(?,?);"
            var insertStatment : OpaquePointer?
            if sqlite3_prepare_v2(db,
                                  insertQueryString,
                                  -1,
                                  &insertStatment,
                                  nil) == SQLITE_OK{
                if sqlite3_step(insertStatment) == SQLITE_DONE{
                    sqlite3_bind_int(insertStatment, 0, Int32(empId))
                    sqlite3_bind_text(insertStatment,
                                      1,
                                      (empName as NSString).utf8String,
                                      -1,
                                      nil)
                }
                else{
                    print("Employee Record successfully inserted")
                }
            }
            
                else {
                    print("Insert Statment Preparation has failed")
                }
                sqlite3_finalize(insertStatment)
            }
    func deleteAnEmployeeRecord(empId : Int){
        
        let deleteQueryString = "DELETE FROM Employee where empId = ?;"
        
        var deleteStatment : OpaquePointer?
        if sqlite3_prepare_v2(db,
                              deleteQueryString, -1,
                              &deleteStatment,
                              nil) == SQLITE_OK{
            sqlite3_bind_int(deleteStatment, 1, Int32(empId))
        }else{
            print("Delete statment preparation failed")
        }
        sqlite3_finalize(deleteStatment)
        }
    func retriveEmployeeRecords()->[Employee]{
        var employees : [Employee] = []
        let retriveEmployeeQueryString = "SELECT * FROM Employee;"
        var retriveStatment : OpaquePointer?
        if sqlite3_prepare_v2(db, retriveEmployeeQueryString, -1, &retriveStatment, nil) == SQLITE_OK{
            while sqlite3_step(retriveStatment) == SQLITE_ROW{
                let retrivedEmpId =  (
                    sqlite3_column_int(retriveStatment, 0))
                let retrivedEmpName = String(describing: String(cString: sqlite3_column_text(retriveStatment, 1)))
                print(retrivedEmpName)
                
                let retrivedEmployee = Employee(empId: Int(retrivedEmpId), empName: retrivedEmpName)
                Employee(empId: Int(retrivedEmpId), empName: retrivedEmpName)
                employees.append(retrivedEmployee)
            }
        }else{
                print("Statment Preparation failed")
            }
            return employees
        }
    }
    

    

