//
//  HomeViewModel.swift
//  TaskApp
//
//  Created by Вячеслав Квашнин on 07.05.2021.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    
    @Published var isNewDate = false
    
    @Published var updateItem : Task!
    
    let calender = Calendar.current
    
    func checkDate() -> String {
        if calender.isDateInToday(date) {
            return "Today"
        } else
        if calender.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            return "Other day"
        }
    }
    
    func updateDate(value: String) {
        if value == "Today" {date = Date()}
        else if value == "Tomorrow" {date = calender.date(byAdding: .day, value: 1, to: Date())! }
    }
    
    func writeData(context: NSManagedObjectContext) {
        if updateItem != nil {
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()
            updateItem = nil
            isNewDate.toggle()
            
            content = ""
            date = Date()
            return
        }
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        
        do {
            try context.save()
            isNewDate.toggle()
            content = ""
            date = Date()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editItem(item: Task) {
        updateItem = item
        date = item.date!
        content = item.content!
        isNewDate.toggle()
        
    }
}
