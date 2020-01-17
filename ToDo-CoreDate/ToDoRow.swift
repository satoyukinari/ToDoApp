//
//  ToDoRow.swift
//  ToDo-CoreDate
//
//  Created by 佐藤志誠 on 2020/01/16.
//  Copyright © 2020 Sato Yukinari. All rights reserved.
//

import SwiftUI

struct ToDoRow: View {
    
    var toDoItem: ToDoItem
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: ChildView()) {
            VStack(alignment: .leading) {
                Text(toDoItem.title ?? "")
                    .font(.title)
                .bold()
                    .padding(.bottom, 5)
                Text("\(toDoItem.createdAt ?? Date(), formatter: ToDoRow.self.dateFormat)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }.navigationBarTitle(Text("ホーム"))
    }
}


