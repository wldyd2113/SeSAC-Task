//
//  BirthViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation

class BirthViewModel {
    var yearText = Obserable("")
    
    var monthText = Obserable("")
    
    var dayText =  Obserable("")
    
    var outputText = Obserable("")
    
    
    init() {
        yearText.outAction  { _ in
            self.resultButtonTapped()
        }
        monthText.outAction  { _ in
            self.resultButtonTapped()
        }
        dayText.outAction  { _ in
            self.resultButtonTapped()
        }
    }
    
    private func resultButtonTapped() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        let today = Calendar.current.startOfDay(for: date)

  
        do {
            let inputDate = try userText(yearText.value, monthText.value, dayText.value)
            let birthDay = Calendar.current.startOfDay(for: inputDate)
            let components = Calendar.current.dateComponents([.day], from: birthDay, to: today)
            let dDay = components.day ?? 0

            outputText.value = "\(dateString) 기준으로 +\(dDay)일째 입니다"
        }
        catch BirthDayError.yearOutOfRange {
            outputText.value = "년도는 2025년 까지 입력할수 있습니다"
        }
        catch BirthDayError.monthOutOfRange {
            outputText.value = "월은 12월까지 있습니다"
        }
        catch BirthDayError.dayOutOfRange {
            outputText.value = "일은 31일까지 있습니다"
        }
        catch {
            outputText.value = "404"
        }
    }
    
    
    private func userText(_ yearText: String, _ monthText: String, _ dayText: String) throws -> Date {
        guard let year = Int(yearText), year <= 2025 else { throw BirthDayError.yearOutOfRange }
        guard let month = Int(monthText),  month <= 12 else { throw BirthDayError.monthOutOfRange }
        guard let day = Int(dayText), day <= 31 else { throw BirthDayError.dayOutOfRange }
        
        let calendar = Calendar.current
        var inputDate = DateComponents()
        inputDate.year = year
        inputDate.month = month
        inputDate.day = day
        guard let newDate = calendar.date(from: inputDate) else { return Date() }
        
        return newDate
    }
}
