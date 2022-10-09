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
            return Color("bongjiramenButton")
        case .cola:
            return Color("colaButton")
        default :
            return Color("waterButton")
        }
    }
    
    var codes: [Int] {
        switch self {
            case .bab:
                return [292, 834]
            case .ham:
                return [1263]
            case .egg:
                return []
            case .chamchi:
                return [1219,1218]
            case .mandu:
                return [1202, 1201]
            case .gimJaban:
                return []
            case .bongjiRamen:
                return [237,238,553]
            case .cola:
                return [1071, 143, 1244]
            case .water:
                return [874]
            }
    }
    
    var goodName: [String] {
        switch self {
        case .bab:
            return ["햇반(210g)", "오뚜기밥(210g)"]
        case .ham:
            return ["스팸 클래식(200g)"]
        case .egg:
            return []
        case .chamchi:
            return ["동원참치 라이트스탠다드(4캔)", "사조참치 살코기 안심따개(4캔)"]
        case .mandu:
            return ["고향만두(1.08kg)","비비고 왕교자(1.05kg)"]
        case .gimJaban:
            return []
        case .bongjiRamen:
            return ["삼양라면(5개입)","진라면 순한맛(5개입)","신라면(5개입)"]
        case .cola:
            return ["펩시콜라(1.8L)","코카콜라(1.8L)" , "칠성사이다 제로(1.5L)"]
        case .water:
            return ["삼다수(2L)"]
        }
    
    }
    var goodImage: [String] {
        switch self {
        case .bab:
            return ["hatban", "ottogibab"]
        case .ham:
            return ["spamClassic"]
        case .egg:
            return []
        case .chamchi:
            return ["dongwonChamchi", "sazoChamchi"]
        case .mandu:
            return ["gohyangMandu","bibigoKingGyoza"]
        case .gimJaban:
            return []
        case .bongjiRamen:
            return ["samyangRamen","JinRamen","shinRamen"]
        case .cola:
            return ["pepsi","cocaCola" , "chilsungCider"]
        case .water:
            return ["samdasu"]
        }
    
    }
    
}
