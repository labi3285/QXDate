# QXDate
##An easy use date handle collection.

###Use
```swift
        // 2017年05月14日 00时49分22秒
        let chinse24 = QXDateFormats.chinse24.string(date)
        // 2017年05月14日 上午 12时49分22秒
        let chinse12 = QXDateFormats.chinse12.string(date)
        // 2017-05-14 00:49:22
        let standard24 = QXDateFormats.standard24.string(date)
        // 2017/05/14 AM 12:49:22
        let slash12 = QXDateFormats.slash12.string(date)
        
        // 1周后
        let nature_chinese = QXDateFormats.nature_chinese.string(date)
        // 1 weeks later
        let nature_english = QXDateFormats.nature_english.string(date)
        
        let qxDate = QXDate(date: date)
        // [QXDate] 2017 05 14 00 49 22
        print(qxDate)
        // 2017
        print(qxDate.year)
        // 5
        print(qxDate.month)
        
        // 今天是这一周的第3天
        let dayIndexInThisWeek = today.qxDayIndexInThisWeek
        // 这个月的第一天是 2017-05-01
        let firstDayInThisMonth = today.qxFirstDayInThisMonth
        // 这个月总共31天
        let numberOfDaysInThisMonth = today.qxNumberOfDaysInThisMonth
        // 这个月总共5周
        let numberOfWeeksInThisMonth = today.qxNumberOfWeeksInThisMonth
        
```

Enjoy!
