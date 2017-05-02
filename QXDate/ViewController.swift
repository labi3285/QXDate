//
//  ViewController.swift
//  QXDate
//
//  Created by Richard.q.x on 2017/5/2.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let today = Date()
        let date = today.addingTimeInterval(1000000)
        
        
        let chinse24 = QXDateFormats.chinse24.string(date)
        let chinse12 = QXDateFormats.chinse12.string(date)
        let standard24 = QXDateFormats.standard24.string(date)
        let slash12 = QXDateFormats.slash12.string(date)
        print(chinse24)
        print(chinse12)
        print(standard24)
        print(slash12)
        
        let nature_chinese = QXDateFormats.nature_chinese.string(date)
        let nature_english = QXDateFormats.nature_english.string(date)
        print(nature_chinese)
        print(nature_english)
        
        let qxDate = QXDate(date: date)
        print(qxDate)
        print(qxDate.year)
        print(qxDate.month)
        
        let dayIndexInThisWeek = today.qxDayIndexInThisWeek
        let firstDayInThisMonth = today.qxFirstDayInThisMonth
        let numberOfDaysInThisMonth = today.qxNumberOfDaysInThisMonth
        let numberOfWeeksInThisMonth = today.qxNumberOfWeeksInThisMonth
        
        print("今天是这一周的第\(dayIndexInThisWeek)天")
        print("这个月的第一天是 \(QXDateFormats.standard_date.string(firstDayInThisMonth))")
        print("这个月总共\(numberOfDaysInThisMonth)天")
        print("这个月总共\(numberOfWeeksInThisMonth)周")
    
    }
}

