//
//  DateExtension.swift
//  TravelTalk
//
//  Created by 차지용 on 7/22/25.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static let firstDateExtension: DateFormatter = {
        let firstDate = DateFormatter()
        firstDate.dateFormat = "yyyy-MM-dd HH:mm"
        return firstDate
    }()
    
    static let dateFormatterExtension: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a.HH.mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
}
