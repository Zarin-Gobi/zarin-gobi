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
    
    @State var productCount: String = ""
    
    
    
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
                
                Image("")
                    .resizable()
                    .frame(width: 209, height: 209)
                    .background(.gray)
                    .padding(.top, 52)
                
                HStack {
                    TextField(text: $productCount, label: {
                        Text("개수가 몇개냐?")
                            .foregroundColor(.gray)
                    })
                    .frame(width: 124, height: 24)
                    .keyboardType(.decimalPad)
                    Text("개")
                        .padding(.leading, 7)
                }.padding(.top, 68)
                
                HStack {
                    TextField(text: $productCount, label: {
                        Text("얼마냐?")
                            .foregroundColor(.gray)
                    })
                    .frame(width: 124, height: 24)
                    .keyboardType(.decimalPad)
                    Text("원")
                        .padding(.leading, 7)
                }.padding(.top, 48)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("결과 보기")
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 56, alignment: .center)
                        .foregroundColor(.white)
                })
                .background(.gray)
                .cornerRadius(12)
                .padding([.leading, .trailing], 16)
                .padding(.bottom, 40)
                
                
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
