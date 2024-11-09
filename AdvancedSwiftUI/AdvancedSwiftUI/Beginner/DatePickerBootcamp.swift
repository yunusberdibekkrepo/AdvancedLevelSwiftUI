//
//  DatePickerBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 7.01.2024.
//

import SwiftUI

struct DatePickerBootcamp: View {
    @State var date = Date()
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date()
    let endingDate: Date = .init()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Date: \(dateFormatter.string(from: date))")
            DatePicker("Date", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
            
            Divider()
                .frame(width: .infinity, height: 10)
                .background(.red)
            
            DatePicker("Date", selection: $date, in: startingDate ... endingDate, displayedComponents: [.date])
            
            DatePicker(selection: $date, in: startingDate ... endingDate, displayedComponents: .date) {
                Image(systemName: "globe")
            }
            .datePickerStyle(.graphical)
        }
        .padding()
    }
}

#Preview {
    DatePickerBootcamp()
}
