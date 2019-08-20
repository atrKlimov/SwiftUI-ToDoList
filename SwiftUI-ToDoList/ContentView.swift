//
//  ContentView.swift
//  SwiftUI-ToDoList
//
//  Created by Artem Klimov on 20/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
    @State private var newToDoItem = ""
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("What's next?")) {
                    HStack {
                        TextField("New Item", text: self.$newToDoItem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            self.newToDoItem = ""
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }   
                    }
                }.font(.headline)
                
                Section(header: Text("To Do's")) {
                    ForEach(self.toDoItems) { toDoItem in 
                        ToDoItemView(title: toDoItem.title!, createdAt: "\(toDoItem.createdAt!)")
                    }.onDelete { IndexSet in
                        let deletedItem = self.toDoItems[IndexSet.first!]
                        self.managedObjectContext.delete(deletedItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("My List"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
