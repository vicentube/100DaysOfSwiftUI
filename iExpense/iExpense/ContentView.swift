// ContentView.swift
// iExpense
//
// Creado el 17/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @State private var showingAddExpense = false
  
  @ObservedObject var expenses = Expenses()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items) { item in
          HStack {
            VStack(alignment: .leading) {
              Text(item.name)
                .font(.headline)
              Text(item.type)
            }
            Spacer()
            Text("$\(item.amount)")
          }
        }
        .onDelete(perform: expenses.removeItems)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(
        leading:
          EditButton(),
        trailing:
          Button(action: { self.showingAddExpense = true }) {
            Image(systemName: "plus")
          })
    }
    .sheet(isPresented: $showingAddExpense) {
      AddView(expenses: self.expenses)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
