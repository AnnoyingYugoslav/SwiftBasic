//
//  DateExtension.swift
//  VariableHolidays
//
//  Created by student on 12/03/2024.
//

import Foundation

extension Date {
    
    static func fromYMD(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        components.timeZone = TimeZone(abbreviation: "GMT")
        return calendar.date(from: components)!
    }
    
    mutating func addDays(numberOfDays: Int) {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.hour = 24 * numberOfDays
        let newDate = calendar.date(byAdding: dateComponent, to: self) ?? Date()
        self = newDate
    }
    
    func dayNumberOfWeek() -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday!
    }
    
    var ymd : DateComponents {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: self)
            return components
        }
    }
    /// Porównuje dwie daty z dokładnością do roku, miesiąca i dnia
     func isSameDate(date: Date) -> Bool {
     let me = self.ymd
     let other = date.ymd
     if me == other {
     return true
     }
     return false
     }

     func daysBetween(date: Date) -> Int {
     let calendar = Calendar.current
     let dateMe = calendar.startOfDay(for: self)
     let dateOther = calendar.startOfDay(for: date)
     let numberOfDays = calendar.dateComponents([.day], from: dateMe, to: dateOther)
     return numberOfDays.day!
     }

     func isWeekend() -> Bool {
     switch self.dayNumberOfWeek() {
     case 1,7: //1 to niedziela, 7 to sobota
     return true
     default:
     return false
     }
     }
    func countWorkDays(date: Date) -> Int {
        let calendar = Calendar.current
        let dateMe = calendar.startOfDay(for: self)
        let dateOther = calendar.startOfDay(for: date)
        
        var currentDay = dateMe
        var counter = -1
        while currentDay <= dateOther{
            if !currentDay.isWeekend() && !currentDay.isBanned() && currentDay != currentDay.isEaster() && currentDay != currentDay.isEaster2(){
                counter += 1
            }
            currentDay = calendar.date(byAdding: .day, value: 1, to: currentDay)!
        }
        return counter
    }
    func isBanned() -> Bool{
        let calender = Calendar.current
        let components = calender.dateComponents([.month, .day], from: self)
        switch(components.month, components.day){
        case (1,6), (1,1), (5, 1), (5, 3), (8,15), (11, 1), (11, 11), (12, 25), (12,26):
            return true
        default:
            return false
        }
    }
    func isEaster2() -> Date{
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day], from: self)
        let a : Int = (components.year! % 19)
        let b = Int(components.year!/100)
        let c : Int = components.year! % 100
        let d = Int(b / 4)
        let e : Int = Int(b) % 4
        let f = Int((b+8)/25)
        let g = Int((b - f + 1) / 3)
        let h : Int = Int(19 * Int(a) + Int(b) - Int(d) - Int(g) + 15) % 30
        let i = Int(c/4)
        let k : Int = Int(c) % 4
        let l = Int(32 + 2 * e + 2 * i + h - k) % 7
        let m = Int((a + 11 * h + 22 * l) / 451)
        let p = Int(h + l - 7 * m + 114) % 31
        let day : Int = Int(p + 1)
        let month : Int = Int(((h+l-7*m+114)/31))
        var easterdate = Date.fromYMD(year: components.year!, month: month, day: day)
        easterdate = calender.date(byAdding: .day, value: 1, to: easterdate)!
        return easterdate
    }
    func isEaster() -> Date{
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day], from: self)
        let a : Int = (components.year! % 19)
        let b = Int(components.year!/100)
        let c : Int = components.year! % 100
        let d = Int(b / 4)
        let e : Int = Int(b) % 4
        let f = Int((b+8)/25)
        let g = Int((b - f + 1) / 3)
        let h : Int = Int(19 * Int(a) + Int(b) - Int(d) - Int(g) + 15) % 30
        let i = Int(c/4)
        let k : Int = Int(c) % 4
        let l = Int(32 + 2 * e + 2 * i + h - k) % 7
        let m = Int((a + 11 * h + 22 * l) / 451)
        let p = Int(h + l - 7 * m + 114) % 31
        let day : Int = Int(p + 1)
        let month : Int = Int(((h+l-7*m+114)/31))
        var easterdate = Date.fromYMD(year: components.year!, month: month, day: day)
        easterdate = calender.date(byAdding: .day, value: 60, to: easterdate)!
        return easterdate
    }
    }
