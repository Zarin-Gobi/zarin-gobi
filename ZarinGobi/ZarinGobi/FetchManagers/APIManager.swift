//
//  APIManager.swift
//  zarinAPI
//
//  Created by Hyung Seo Han on 2022/10/08.
//

import SwiftUI
import UIKit




enum XMLKey: String{
    case goodInspectDay = "goodInspectDay"
    case entpId = "entpId"
    case goodId = "goodId"
    case goodPrice = "goodPrice"
    case inputDttm = "inputDttm"
}


class APIManger: NSObject, ObservableObject, XMLParserDelegate{
    var lowestPrice : Int = 0
    var hightestPrice : Int = 0
    
    var goodItems: [goodItem] = []
    var xmlDictionary: [String : String]?
    var crtElementType: XMLKey?
    
    
    override init(){}

    public func loadData(_ goodsId: Int){
        goodItems = []
       
        let url = URL(string:  "http://openapi.price.go.kr/openApiImpl/ProductPriceInfoService/getProductPriceInfoSvc.do?serviceKey=yRZdAPyLom3Bl%2BZt86RiOBXIB04w9kHjGSdaxEyNXINnb6iaYuGmiI0STxHpJK5dS4j8XX6aH6wFGIvTuL5bkQ%3D%3D&goodInspectDay=20221007&goodId=\(goodsId)")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            
            guard let data = data, error == nil else{
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            guard self.goodItems.count != 0 else{
                return
            }
            self.goodItems.sort{Int($0.goodPrice)! < Int($1.goodPrice)!}
            self.lowestPrice = Int(self.goodItems[0].goodPrice)!
            self.hightestPrice = Int(self.goodItems[self.goodItems.count-1].goodPrice)!
        
        }
        task.resume()
        
       
        
        
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        
        if elementName == "iros.openapi.service.vo.goodPriceVO"{
            xmlDictionary = [:]
        }else if elementName == "goodInspectDay"{
            crtElementType = .goodInspectDay
        }else if elementName == "entpId"{
            crtElementType = .entpId
        }else if elementName == "goodId"{
            crtElementType = .goodId
        }else if elementName == "goodPrice"{
            crtElementType = .goodPrice
        }else{
            crtElementType = .inputDttm
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard xmlDictionary != nil, let crtElementType = self.crtElementType else{
            return
        }
        xmlDictionary?.updateValue(string, forKey: crtElementType.rawValue)
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard let xmlDictionary = self.xmlDictionary else {
            return
        }
        if elementName == "iros.openapi.service.vo.goodPriceVO"{
            
           
            var item = goodItem(goodInspectDay: "", entpId: "", goodId: "", goodPrice: "", inputDttm: "")
            guard let goodInspectDay = xmlDictionary[XMLKey.goodInspectDay.rawValue],
                  let entpId = xmlDictionary[XMLKey.entpId.rawValue],
                  let goodId = xmlDictionary[XMLKey.goodId.rawValue],
                  let goodPrice = xmlDictionary[XMLKey.goodPrice.rawValue],
                  let inputDttm = xmlDictionary[XMLKey.inputDttm.rawValue] else{
                return
            }
            
            item.goodInspectDay = goodInspectDay
            item.entpId = entpId
            item.goodId = goodId
            item.goodPrice = goodPrice
            item.inputDttm = inputDttm
            
            
            goodItems.append(item)
            self.xmlDictionary = nil
            
        }
        crtElementType = nil
    }
}
