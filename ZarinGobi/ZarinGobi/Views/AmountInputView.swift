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
    
    @State var userInputProductCount: String = ""
    @State var userInputProductPrice: String = ""
    @State private var contentSize: CGSize = .zero
    @State var shouldScroll: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            SelectProductButton(productNames: testProductNames)
                        }
                        .padding()
                        .background(.white)
                        .overlay(
                            GeometryReader { geo in
                            Color.clear.onAppear {
                                contentSize = geo.size
                                if contentSize.width >= UIScreen.main.bounds.width {
                                    shouldScroll = true
                                }
                            }
                        })
                        
                    }
                    .simultaneousGesture(DragGesture(minimumDistance: shouldScroll ? 20 : 0), including: .all)
                    .frame(maxWidth: contentSize.width, maxHeight: 63)
                }
                
                Image("")
                    .resizable()
                    .frame(width: 209, height: 209)
                    .background(.gray)
                    .padding(.top, 52)
                
                MakeUserInputTextField(productCount: $userInputProductCount, textFieldHint: "개수가 몇개냐?", textFieldUnit: "개").padding(.top, 68)
                
                MakeUserInputTextField(productCount: $userInputProductPrice, textFieldHint: "얼마냐?", textFieldUnit: "원").padding(.top, 48)
                
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


struct MakeUserInputTextField: View {
    @Binding var productCount: String
    let textFieldHint: String
    let textFieldUnit: String
    
    var body: some View {
        HStack {
            TextField(text: $productCount, label: {
                Text("\(textFieldHint)")
                    .foregroundColor(.gray)
            })
            .frame(width: 124, height: 24)
            .keyboardType(.decimalPad)
            Text("\(textFieldUnit)")
                .padding(.leading, 7)
        }
    }
}

struct SelectProductButton: View {
    let productNames: [String]
    
    var body: some View {
        ForEach(productNames, id: \.self) { title in
            Button(action: {
                
            }, label: {
                Text("\(title)")
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 14)
                    .padding([.top, .bottom], 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            })
            
        }

        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Rectangle().foregroundColor(.white))
    }
}
