//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                VStack(alignment: .center) {
                    Text("Youtine")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(color: Color.yellow, radius: 1, x: 2, y: 2)
                        .underline(true, pattern: .solid)
                    
                    // card start
                    VStack {
                        Spacer()
                        HStack() {
                            Text("Morning Routine")
                            Spacer()
                            Text("8:00 am")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        HStack {
                            Text("Tasks completed")
                            Spacer()
                            Text("2/3")
                        }
                        Spacer()
                    }
                    .padding(50)
                    .frame(height: height / 4)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.red, lineWidth: 2)
                    )
                    // card end
                    

                    Spacer()
                    
                    // card start
                    VStack {
                        Spacer()
                        HStack() {
                            Text("Morning Routine")
                            Spacer()
                            Text("8:00 am")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        HStack {
                            Text("Tasks completed")
                            Spacer()
                            Text("2/3")
                        }
                        Spacer()
                    }
                    .padding(50)
                    .frame(height: height / 4)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.red, lineWidth: 2)
                    )
                    // card end

                    Spacer()
                    
                    // card start
                    VStack {
                        Spacer()
                        HStack() {
                            Text("Morning Routine")
                            Spacer()
                            Text("8:00 am")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        HStack {
                            Text("Tasks completed")
                            Spacer()
                            Text("2/3")
                        }
                        Spacer()
                    }
                    .padding(50)
                    .frame(height: height / 4)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.red, lineWidth: 2)
                    )
                    // card end
                    
                    
                    Spacer()
                }
                .frame(width: width, height: height)
                
            }
        }
        .preferredColorScheme(.dark)
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Routine(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { routines[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
