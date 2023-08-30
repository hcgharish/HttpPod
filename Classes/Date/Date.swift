//
//  Date.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
class Date1: NSDate {
}
public extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    func all(from date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.year, .month,
                                                .hour, .day, .minute, .second],
                                               from: date, to: self)
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    func getStringDate(_ formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: self)
    }
    func getUTCStringDate(_ formate: String) -> String {
        let timeZoneLocal = NSTimeZone.local as TimeZone?

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZoneLocal
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func newDateByAppending (_ date: Date, _ by: Int, _ type: NewDateType) -> Date {
        if type == .year {
            return Calendar.current.date(byAdding: .year, value: by, to: date)!
        } else if type == .month {
            return Calendar.current.date(byAdding: .month, value: by, to: date)!
        } else if type == .day {
            return Calendar.current.date(byAdding: .day, value: by, to: date)!
        } else if type == .hour {
            return Calendar.current.date(byAdding: .hour, value: by, to: date)!
        } else if type == .minute {
            return Calendar.current.date(byAdding: .minute, value: by, to: date)!
        } else if type == .second {
            return Calendar.current.date(byAdding: .second, value: by, to: date)!
        }
        
        return Date()
    }
}

enum NewDateType {
    case year
    case month
    case day
    case hour
    case minute
    case second
}
