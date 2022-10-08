//
//  AmountInputView.swift
//  ZarinGobi
//
//  Created by Eunbi Han on 2022/10/08.
//

import SwiftUI

struct AmountInputView: View {
    
    let testProductNames: [String] = ["햇반 (210g)", "오뚜기밥 (210g)"]
    let testProductImages: [String] = ["rice1", "rice2"]
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    ForEach(testProductNames, id: \.self) { title in
                        Button(action: {
                            
                        }, label: {
                            Text("\(title)")
                        })
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 14)
                        .padding([.top, .bottom], 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                    }
                }
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 209, height: 209)
                    .background(.gray)
                    .padding(.top, 52)
                    
                
                
                
                
                
            }
        }
    }
    
    private func clickedProductButton() {
        
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView()
    }
}
