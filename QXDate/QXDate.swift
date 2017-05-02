//
//  QXDate.swift
//  QXDateDemo
//
//  Created by Richard.q.x on 2017/4/28.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import Foundation

/// support date formats
enum QXDateFormats: String {
    
    // standard 24
    case standard24 =           "yyyy-MM-dd HH:mm:ss"
    case standard_date =        "yyyy-MM-dd"
    case standard24_time =      "HH:mm:ss"
    case standard12 =           "yyyy-MM-dd aa hh:mm:ss @AM @PM"
    case standard12_time =      "aa hh:mm:ss @AM @PM"
    
    // slash 24
    case slash24 =              "yyyy/MM/dd HH:mm:ss"
    case slash_date =           "yyyy/MM/dd"
    case slash12 =              "yyyy/MM/dd aa hh:mm:ss @AM @PM"
    
    // chinese
    case chinse24 =             "yyyy年MM月dd日 HH时mm分ss秒"
    case chinse_date =          "yyyy年MM月dd日"
    case chinse24_time =        "HH时mm分ss秒"
    case chinse12 =             "yyyy年MM月dd日 aa hh时mm分ss秒 @上午 @下午"
    case chinse12_time =        "aa hh时mm分ss秒 @上午 @下午"
    
    // segments
    case segments =             "yyyy MM dd HH mm ss"
    
    // nature
    case nature_chinese =       "nature @刚刚... @分钟前 @分钟后 @小时前 @小时后 @昨天 @明天 @前天 @后天 @天前 @天后 @周前 @周后 @月前 @月后 @年前 @年后"
    case nature_english =       "nature @just now @ minutes ago @ minutes later @ hours ago @ hours later @yesterday @tomorrow @the day before yesterday @the day after tomorrow @ days ago @ days later @ weeks ago @ weeks later @ months ago @ months later @years ago @years later"

    /// get date from formate string
    func date(_ dateString: String) -> Date? {
        assert(!self.rawValue.hasPrefix("nature"), "nature string can not transform into date")
        _initFormatter(fmt: self)
        return QXDateFormats._formatter.date(from: dateString)
    }
    /// get formate string from date
    func string(_ date: Date) -> String {
        if self.rawValue.hasPrefix("nature") {
            let components = self.rawValue.components(separatedBy: " @")
            return QXDateFormats._getNature(date, components)
        } else {
            _initFormatter(fmt: self)
            return QXDateFormats._formatter.string(from: date)
        }
    }
    
    /// init static formatter
    private func _initFormatter(fmt: QXDateFormats) {
        let formatter = QXDateFormats._formatter
        let components = fmt.rawValue.components(separatedBy: " @")
        if components.count >= 3 {
            formatter.dateFormat = components[0]
            formatter.amSymbol = components[1]
            formatter.pmSymbol = components[2]
        } else {
            formatter.dateFormat = fmt.rawValue
        }
    }
    /// static formatter for use
    private static var _formatter = DateFormatter()
    
    /// make nature date string
    static func _getNature(_ date: Date, _ components: [String]) -> String {

        let justNow = components[1]
        let minutesAgo = components[2]
        let minutesLater = components[3]
        let hoursAgo = components[4]
        let hoursLater = components[5]
        let yesterday = components[6]
        let tomorrow = components[7]
        let dayBeforeYesterday = components[8]
        let dayLaterTomorrow = components[9]
        let daysAgo = components[10]
        let daysLater = components[11]
        let weeksAgo = components[12]
        let weeksLater = components[13]
        let monthsAgo = components[14]
        let monthsLater = components[15]
        let yearsAgo = components[16]
        let yearsLater = components[17]

        let seconds: Int = Int(date.timeIntervalSince1970 - Date().timeIntervalSince1970)
        // 60 minutes
        if (abs(seconds / 3600) < 1) {
            let minutes = seconds / 60
            if abs(minutes) <= 0 {
                return justNow
            } else {
                if minutes > 0 {
                    return "\(minutes)" + minutesLater
                } else {
                    return "\(minutes)" + minutesAgo
                }
            }
        }
        // 1-24 hour
        else if abs(seconds / 86400) <= 1 {
            let hours = seconds / 3600
            if hours > 0 {
                return "\(hours)" + hoursLater
            } else {
                return "\(hours)" + hoursAgo
            }
        }
        // more than one day
        else {
            let days = seconds / 86400
            if abs(days) <= 1 {
                if days > 0 {
                    return tomorrow
                } else {
                    return yesterday
                }
            } else if abs(days) == 2 {
                if days > 0 {
                    return dayLaterTomorrow
                } else {
                    return dayBeforeYesterday
                }
            } else if abs(days) <= 7 {
                if days > 0 {
                    return "\(days)" + daysLater
                } else {
                    return "\(days)" + daysAgo
                }
            } else if abs(days) <= 30 {
                if days > 0 {
                    return "\(days / 7)" + weeksLater
                } else {
                    return "\(days / 7)" + weeksAgo
                }
            } else if abs(days) < 365 {
                if days > 0 {
                    return "\(days / 30)" + monthsLater
                } else {
                    return "\(days / 30)" + monthsAgo
                }
            } else {
                if days > 0 {
                    return "\(days / 365)" + yearsLater
                } else {
                    return "\(days / 365)" + yearsAgo
                }
            }
        }
    }
}

class QXDate: CustomStringConvertible {
    
    // segs
    let year: Int
    let month: Int
    let day: Int
    let hour: Int
    let minute: Int
    let second: Int
    
    /// judge exist of year, month and day segs, true if any of them is zero
    var isTimeMode: Bool {
        let dateExist = year != 0 && month != 0 && day != 0
        return !dateExist
    }
    
    /// Date
    var date: Date {
        if let date = _initDate {
            return date
        }
        return QXDateFormats.segments.date(segmentFormateString)!
    }
    
    /// date formate string
    var segmentFormateString: String {
        return "\(year) \(month) \(day) \(hour) \(minute) \(second)"
    }
    
    /// CustomStringConvertible
    var description: String {
        return "[QXDate] " + QXDateFormats.segments.string(date)
    }
    
    /// init with year, month and day
    convenience init(year: Int, month: Int, day: Int) {
        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    /// init with hour, minute and second
    convenience init(hour: Int, minute: Int, second: Int) {
        self.init(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0)
    }
    /// init with Date
    convenience init(date: Date) {
        let dateStr = QXDateFormats.segments.string(date)
        let segStrs = dateStr.components(separatedBy: " ")
        assert(segStrs.count >= 6)
        self.init(year:     (segStrs[0] as NSString).integerValue,
                  month:    (segStrs[1] as NSString).integerValue,
                  day:      (segStrs[2] as NSString).integerValue,
                  hour:     (segStrs[3] as NSString).integerValue,
                  minute:   (segStrs[4] as NSString).integerValue,
                  second:   (segStrs[5] as NSString).integerValue)
        self._initDate = date
    }
    /// base init
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    /// private
    private var _initDate: Date?
    
}


extension Date {
    
    /// number of days in date month of date year [ Computed ]
    var qxNumberOfDaysInThisMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: self)!.count
    }
    
    /// first day in date month of date year  [ Computed ]
    var qxFirstDayInThisMonth: Date {
        var date: Date = Date()
        var interval: TimeInterval = 0
        _ = Calendar.current.dateInterval(of: .month, start: &date, interval: &interval, for: self)
        return date
    }
    
    /// the day of date day in this week (first day is weekend)  [ Computed ]
    var qxDayIndexInThisWeek: Int {
        return Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: self)!
    }
    
    /// week count in date month  [ Computed ]
    var qxNumberOfWeeksInThisMonth: Int {
        let weekDay = self.qxFirstDayInThisMonth.qxDayIndexInThisWeek
        var totalDays = self.qxNumberOfDaysInThisMonth
        
        var weekCount = 0
        if weekDay > 1 {
            weekCount += 1
            totalDays -= (7 - weekDay + 1)
        }
        weekCount += totalDays / 7
        weekCount += (totalDays % 7 > 0) ? 1 : 0
        return weekCount
    }
    
}
