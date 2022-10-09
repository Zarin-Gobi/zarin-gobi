//
//  FoodButtonName.swift
//  ZarinGobi
//
//  Created by 최윤석 on 2022/10/08.
//

import Foundation
import SwiftUI

enum FoodButtonName: String {
    case bab = "즉석밥"
    case ham = "햄"
    case egg = "계란"
    case chamchi = "참치"
    case mandu = "만두"
    case gimJaban = "김자반"
    case bongjiRamen = "봉지 라면"
    case cola = "콜라"
    case water = "물"
    
    var title: String { self.rawValue }
    
    var backgroundColor: Color {
        //TODO: 버튼 컬러 색상 변경
        switch self {
        case .bab:
            return Color(.black)
        case .ham:
            return Color(.black)
        case .egg:
            return Color(.black)
        case .chamchi:
            return Color(.black)
        case .mandu:
            return Color(.black)
        case .gimJaban:
            return Color(.black)
        case .bongjiRamen:
            return Color(.black)
        case .cola:
            return Color(.black)
        default :
            return Color(.black)
        }
    }
    
    
    
}
