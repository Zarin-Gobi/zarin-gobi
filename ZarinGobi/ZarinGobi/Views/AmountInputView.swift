//
//  AmountInputView.swift
//  ZarinGobi
//
//  Created by Eunbi Han on 2022/10/08.
//

import SwiftUI

struct AmountInputView: View {
    
    @State var userInputProductCount: String = ""
    @State var userInputProductPrice: String = ""
    @State private var contentSize: CGSize = .zero
    @State var shouldScroll: Bool = false
    @FocusState private var showKeyboard: Bool
    
    let testProductNames: [String] = ["햇반 (210g)", "오뚜기밥 (210g)"]
    let testProductImages: [String] = ["rice1", "rice2"]
    let categoryTitle: String = "즉석밥"
    
    
    var body: some View {
        
        VStack {
            customNavigationBar(testProductNames: testProductNames, categoryTitle: categoryTitle, shouldScroll: $shouldScroll, contentSize: $contentSize)
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Image("")
                                .resizable()
                                .frame(width: 240, height: 240)
                                .background(.gray)
                                .padding(.top, 12)
        
                            MakeUserInputTextField(productCount: $userInputProductCount, textFieldHint: "개수가 몇개냐?", textFieldUnit: "개", showKeyboard: $showKeyboard).padding(.top, 32)
        
                            MakeUserInputTextField(productCount: $userInputProductPrice, textFieldHint: "얼마냐?", textFieldUnit: "원", showKeyboard: $showKeyboard).padding(.top, 61)
        
                            Spacer(minLength: 140)
                            
                            ShowResultButton()
                            
                            Spacer(minLength: 40)
            
            
                        }
                        .navigationTitle("test").navigationBarTitleDisplayMode(.inline)
            
                    }
        }
        .navigationBarHidden(true)
        .onTapGesture {
            showKeyboard = false
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

// 유저 입력을 받는 텍스트 필드
struct MakeUserInputTextField: View {
    @Binding var productCount: String
    
    let textFieldHint: String
    let textFieldUnit: String
    
    var showKeyboard: FocusState<Bool>.Binding
     
    var body: some View {
        HStack {
            ZStack {
                TextField(text: $productCount, label: {
                    Text("\(textFieldHint)")
                        .foregroundColor(.gray)
                })
                .frame(width: 133, height: 25)
                .keyboardType(.decimalPad)
                .focused(showKeyboard)
                
                Rectangle()
                    .fill(Color("DeactivateTextfieldColor"))
                    .frame(width: 132, height: 4)
                    .offset(x: 0, y: 25)
            }
            
            Text("\(textFieldUnit)")
                .padding(.leading, 7)
        }
    }
}

// 카데고리 안에서 세부 품목을 고를 수 있는 버튼
struct SelectProductButton: View {
    let productNames: [String]
    
    var body: some View {
        
        ForEach(0..<productNames.count) { index in
            Button(action: {
                
            }, label: {
                Text("\(productNames[index])")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 14)
                    .padding([.top, .bottom], 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            })
            .id(index)
            .padding(.bottom, 12)
            .padding(.top, 16)
            
        }
        
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Rectangle().foregroundColor(.white))
    }
}

// 커스텀 네비게이션 바 & 세부 상품 선택 버튼
struct customNavigationBar: View {
    let testProductNames: [String]
    let categoryTitle: String
    
    @Binding var shouldScroll: Bool
    @Binding var contentSize: CGSize
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 24,weight: .medium))
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                            .padding([.bottom, .top], 10)
                    })
                    Spacer()
                    Spacer()
                }
                
                Text("\(categoryTitle)")
                    .font(.system(size: 17, weight: .semibold))
                    .padding([.top], 11)
            }.frame(height: 44)
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        SelectProductButton(productNames: testProductNames)
                    }
                    .padding(1)
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
                .frame(maxWidth: contentSize.width, maxHeight: 64)
            }
            .frame(width: UIScreen.main.bounds.width, height: 64, alignment: .center)
            
        }.frame(width: UIScreen.main.bounds.width, height: 107)
        
    }
}

struct ShowResultButton: View {
    
    var body: some View {
        NavigationLink(destination: ShowPriceView(), label: {
            Text("결과 보기")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 56,maxHeight: 56, alignment: .center)
                .foregroundColor(.white)
                .background(.gray)
                .cornerRadius(12)
                .padding([.leading, .trailing], 16)
        })

        
    }
}
