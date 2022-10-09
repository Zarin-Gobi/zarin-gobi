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
    case water = "생수"
    
    var title: String { self.rawValue }
    
    var backgroundColor: Color {
        switch self {
        case .bab:
            return Color("babButton")
        case .ham:
            return Color("hamButton")
        case .egg:
            return Color("eggButton")
        case .chamchi:
            return Color("chamchiButton")
        case .mandu:
            return Color("manduButton")
        case .gimJaban:
            return Color("gimjabanButton")
        case .bongjiRamen:
            return Color("bongjiRamenButton")
        case .cola:
            return Color("colaButton")
        default :
            return Color("waterButton")
        }
    }
    
    
    
}
