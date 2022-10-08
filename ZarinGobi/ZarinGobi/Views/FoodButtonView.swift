//
//  FoodButtonView.swift
//  ZarinGobi
//
//  Created by 최윤석 on 2022/10/08.
//

import SwiftUI

struct FoodButtonView: View {
    
    var title: String
    
    var body: some View {
        NavigationLink {
            AmountInputView()
        } label: {
            Text(title)
        }
        .font(.system(size: 20, weight: .medium))
        .foregroundColor(.white)
        .frame(width: 114.0, height: 80.0)
        .background(.black)
        .cornerRadius(12)
        
    }
}

struct FoodButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FoodButtonView(title: "즉석밥")
    }
}
