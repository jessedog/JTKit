//
//  Date+JT.swift
//  TicketsBusiness
//
//  Created by tesla on 2017/5/4.
//  Copyright © 2017年 卖票邦. All rights reserved.
//

import Foundation

extension Date {
    
    func string(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    static func countdownString( timeInterval: TimeInterval, string: String = "") -> String {
        
        if timeInterval > 60 * 60 * 24 {
            let dayTimeInterval = timeInterval
            let day = Int(dayTimeInterval / (60 * 60 * 24))
            let str = day > 0 ? "\(day)天" : ""
            return str
        } else if timeInterval > 60 * 60 {
            let hourTimeInterval = timeInterval
            let hour = Int(hourTimeInterval / (60 * 60))
            var str = "\(hour)"
            if hour < 10 {
                str = "0\(hour)"
            } else if hour < 1 {
                str = "00"
            }
            
            return countdownString(timeInterval: timeInterval - Double(hour * 60 * 60), string: string + str)
        } else if timeInterval > 60 {
            let minuteTimeInterval = timeInterval
            let minute = Int(minuteTimeInterval / 60)
            var str = "\(minute)"
            if minute < 10 {
                str = "0\(minute)"
            } else if minute < 1 {
                str = "00"
            }
            if !string.isEmpty { str = ":" + str }
            return countdownString(timeInterval: timeInterval - Double(minute * 60), string: string + str)
        } else {
            let second = Int(timeInterval)
            var str = "\(second)"
            if second < 10 {
                str = "0\(second)"
            } else if second < 1 {
                str = "00"
            }
            if !string.isEmpty { str = ":" + str }
            return string + str
        }
    }
    
    static func date(from string: String, withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.date(from: string)
    }
    
    // 将日期字符串转换成另一个指定格式的日期字符串
    static func string(from string: String,
                       formFormat format1: String,
                       toFormat format2: String) -> String {
        let date = self.date(from: string, withFormat: format1)
        return date?.string(withFormat: format2) ?? ""
    }
}
