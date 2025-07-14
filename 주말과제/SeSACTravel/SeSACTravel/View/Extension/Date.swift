//
//  Date.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/14/25.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func getDateString()  {
        let firstDateformatter = DateFormatter()
        firstDateformatter.dateFormat = "yyMMdd"
        
        let dateFormatter = DateFormatter()
        return dateFormatter.dateFormat = "yy년 MM월 dd일"
    }

}
