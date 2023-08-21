//
//  RealmManager.swift
//  ToDowithDB
//
//  Created by Naomi on 1/8/23.
//

import Foundation
import RealmSwift

class RealmManager : ObservableObject {
    //question mark means this var is optional in case opening realm throws an error
    private(set) var localRealm : Realm?
    //array called tasks containing type Task
    @Published private(set) var tasks : [Task] = []
    
    //whenever we initialize this class we will open realm 
    init(){
        openRealm()
        getTasks()
    }
    
    func openRealm() {
        do{
            //if want to update schema, need code on migrationblock
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration=config
            
            //realm needs to be "opened" for data to be put into the database
            localRealm = try Realm()
        }catch{
            print("Error opening Realm : \(error)")
        }
    }
    
    //writing into database function
    func addTask(taskTitle:String){
        if let localRealm = localRealm {
            do{
                //write into database , transfer data from our schema to database schema
                try localRealm.write{
                    let newtask = Task(value : ["title" :taskTitle, "completed" : false])
                    localRealm.add(newtask)
                    getTasks()
                    print("Added new task to database : \(newtask)")
                }
            }catch{
                print("Error adding task to database")
            }
        }
    }
    
    func getTasks(){
        if let localRealm = localRealm {
            // get all objects of type task in local realm, sorted by if they are completed or not
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach{ task in
                tasks.append(task)}
            
        }
    }
    
    func updateTasks(id:ObjectId, completed:Bool){
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format:"id == %@",id))
                guard !taskToUpdate.isEmpty else {return}
                
                try localRealm.write{
                    taskToUpdate[0].completed=completed
                    getTasks()
                    print("Updated task status to database")
                }
                
            }catch{
                print("Error updating task \(id) to database \(error)")
            }
        }
    }
    
    func deleteTask( id:ObjectId){
        if let localRealm = localRealm{
            do{
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format:"id == %@",id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write{
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task from database")
                }
                
            }catch{
                print("Error deleted task from database")
            }
        }
    }
}
