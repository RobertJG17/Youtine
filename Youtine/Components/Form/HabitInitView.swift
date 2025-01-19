//
//  RoutineInitView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct HabitInitView: View {
    var width: CGFloat
    var height: CGFloat
    @Binding var habits: [Habit]
    @Binding var showingRoutineInit: Bool
    
    @State var label: String = ""
    @State var desc: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        showingRoutineInit = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        showingRoutineInit = false
                        
                        if label != "" && desc != "" {
                            habits.append(
                                Habit(
                                    label: label,
                                    desc: desc
                                )
                            )
                        }
                    } label: {
                        Text("Done")
                    }
                    .disabled(label == "" || desc == "")
                    
                }
                
                Spacer()
                                
                HStack(alignment: .bottom) {
                    Text("Label: ")
                        .font(.system(size: 30, weight: .thin))
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 2.5) {
                        TextField(text: $label) {}
                            .frame(width: 230, alignment: .center)
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: 217, height: 1)
                            .padding(.trailing, 15)
                    }
                    .font(.system(size: 28, weight: .thin))
                }
                
                HStack(alignment: .top) {
                    Text("Description: ")
                        .font(.system(size: 20, weight: .thin))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        TextEditor(text: $desc) // Multiline text input
                            .frame(height: 150) // Set a height for the TextEditor
                            .border(Color.gray, width: 1) // Optional: Add a border
                            .padding()
                    }
                    .font(.system(size: 18, weight: .thin))
                }
                
                Spacer()
            }
            .padding(20)
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HabitInitView(
        width: 402.0,
        height: 687.666667,
        habits: .constant([]),
        showingRoutineInit: .constant(true)
    )
}
