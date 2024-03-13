//
//  ContentView.swift
//  VariableHolidays
//
//  Created by Krzysztof Garsztka and Wojciech Kaczmarek on 12/03/2024.
//

import SwiftUI
struct ContentView: View {

 let dateFormatter: DateFormatter = {
 let formatter = DateFormatter()
 formatter.dateFormat = "dd MMMM yyyy - hh:mm"
 return formatter
 }()

 @State var dateStart = Date()
 @State var dateEnd = Date()

 var body: some View {
 VStack {
 Text("Date calculator").font(.title)
 Spacer()
 DatePicker("Enter first date",selection: $dateStart, in: ...dateEnd,
displayedComponents: .date)
 .datePickerStyle(.automatic)
 DatePicker("Enter second date",selection: $dateEnd, in: dateStart...,
displayedComponents: .date)
 .datePickerStyle(.automatic)
 Spacer()
 Text("Days between: \(dateStart.daysBetween(date: dateEnd))")
     Text("Work days between: \(dateStart.countWorkDays(date: dateEnd))")
 Spacer()
 }
 .padding()
 }
}
#Preview {
 ContentView()
}
