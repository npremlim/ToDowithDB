//
//  AddTaskView.swift
//  ToDowithDB
//
//  Created by Naomi on 1/8/23.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var realmManager : RealmManager
    @State private var title : String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create a new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // this assigns the userinput to private variable title
            TextField("Enter your task here: ",text: $title )
                .textFieldStyle(.roundedBorder)
            
            Button{
                if title != "" {
                    realmManager.addTask(taskTitle: title)
                }
                    
                dismiss()
            }label:{
                Text("Add Task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.484, saturation: 1.0, brightness: 0.554))
                    .cornerRadius(50)
                
            }
            Spacer()
            
            
        }
        .padding(.top,40)
        .padding(.horizontal)
        .background(Color(hue: 0.484, saturation: 0.161, brightness: 0.957))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
