//
//  TimePickerView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var showingTimePicker: Bool
    @Binding var start: String
    
    @State private var selectedTime = Date()
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight

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
        .frame(
            width: screenWidth.wrappedValue,
            height: screenHeight.wrappedValue
        )
        .preferredColorScheme(.dark)
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        // Adjust locale to use AM/PM format if needed
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let rawString = formatter.string(from: selectedTime)
        
        // ???: Normalize spaces to standard spaces (U+0020)
        return rawString.replacingOccurrences(of: "\u{202F}", with: " ")
    }
}

#Preview {
    TimePickerView(
        showingTimePicker: .constant(true),
        start: .constant("8:00 AM")
    )
}
