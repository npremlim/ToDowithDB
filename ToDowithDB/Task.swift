//
//  Task.swift
//  ToDowithDB
//
//  Created by Naomi on 1/8/23.
//

import Foundation
import RealmSwift

class Task : Object, ObjectKeyIdentifable {
    //auto generated object id from realm
    
    @Persisted(primaryKey: true) var id : ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
  
