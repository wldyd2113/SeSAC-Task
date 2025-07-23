//
//  DateExtension.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static let firstDateExtension: DateFormatter = {
        let firstDate = DateFormatter()
        firstDate.dateFormat = "yyyyMMdd"
        return firstDate
    }()
    
    static let dateFormatterExtension: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
}
