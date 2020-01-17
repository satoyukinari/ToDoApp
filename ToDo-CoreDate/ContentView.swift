//
//  ContentView.swift
//  ToDo-CoreDate
//
//  Created by 佐藤志誠 on 2020/01/16.
//  Copyright © 2020 Sato Yukinari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: ToDoItem().fetch()) var toDoItems: FetchedResults<ToDoItem>
    
    @State var isShow: Bool = false
   
    @State private var newToDoItem = ""
    init() {
           UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.purple]
           UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.purple]
    }
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("新規")) {
                    HStack {
                        TextField("友達の名前", text: $newToDoItem)
                        Button(
                            action: {
                                if self.newToDoItem.isEmpty{
                                    self.isShow = true
                                }else{
                                    let toDoItem = ToDoItem(context: self.managedObjectContext)
                                    toDoItem.title = self.newToDoItem
                                    toDoItem.createdAt = Date()
                                    toDoItem.id = UUID().uuidString
                                    
                                    do{
                                        try self.managedObjectContext.save()
                                    }catch{
                                        print(error)
                                    }
                                    
                                    self.newToDoItem = ""
                                }
                            },
                            label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                                
                        })
                    }
                }
                .font(.headline)
                Section(header: Text("友達")) {
                    
                        ForEach(self.toDoItems, id: \.id) { item in
                            ToDoRow(toDoItem: item)
                        
                        }.onDelete {IndexSet in
                            let deleteItem = self.toDoItems[IndexSet.first!]
                            self.managedObjectContext.delete(deleteItem)
                            do {
                                try self.managedObjectContext.save()
                            }catch{
                                print(error)
                            }
                    }
                }
            }
            .navigationBarTitle("ホーム")
            .navigationBarItems(trailing: EditButton())
        }.alert(isPresented: $isShow, content: {
            Alert(title: Text("だめ！"), message: Text("名前が入力されていません"), dismissButton: .default(Text("OK")))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
