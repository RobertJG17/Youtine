//
//  TimePickerView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct TimePickerView: View {
    var width: CGFloat
    var height: CGFloat
    @Binding var showingTimePicker: Bool
    @Binding var start: String
    
    @State private var selectedTime = Date()

    var body: some View {
        VStack {
            Text("Select a Time")
                .font(.headline)

            DatePicker(
                "Time",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            
            Button {
                showingTimePicker.toggle()
                start = formattedTime
            } label: {
                Text("Done")
            }
        }
        .frame(width: width, height: height)
        .preferredColorScheme(.dark)
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        // Adjust locale to use AM/PM format if needed
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: selectedTime)
    }
}

#Preview {
    TimePickerView(
        width: 402.0,
        height: 687.6666666667,
        showingTimePicker: .constant(true),
        start: .constant("8:00 AM")
    )
}
