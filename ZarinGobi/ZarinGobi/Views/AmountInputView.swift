//
//  AmountInputView.swift
//  ZarinGobi
//
//  Created by Eunbi Han on 2022/10/08.
//

import SwiftUI

struct AmountInputView: View {
    enum Field: Hashable {
        case userCount
        case userPrice
    }
    
    @State var userInputProductCount: String = ""
    @State var userInputProductPrice: String = ""
    @State private var contentSize: CGSize = .zero
    @State var shouldScroll: Bool = false
    @FocusState private var showKeyboard: Bool
    @State var keyboardText = "다음"
    @FocusState private var focusedField: Field?
    @FocusState private var showKeyboardCount: Bool
    @FocusState private var showKeyboardPrice: Bool
    @State var goodCodes: [Int] = []
    @State var selectedButtonIndex = 0
    @ObservedObject var priceManager: APIManger
    
    @State var testProductNames: [String] = []
    @State var testProductImages: [String] = []
    @State var categoryTitle: String = ""
    

    @State var lowest: Int = 0
    @State var highest: Int = 0
    @State var reloader: Bool = false
    
    var body: some View {
        
        VStack {
            customNavigationBar(testProductNames: testProductNames, categoryTitle: categoryTitle, shouldScroll: $shouldScroll, contentSize: $contentSize, selectedButtonIndex: $selectedButtonIndex, goodCodes: $goodCodes,priceManager: priceManager)
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Image(testProductImages[selectedButtonIndex])
                                .resizable()
                                .frame(width: 240, height: 240)
                                .background(.gray)
                                .padding(.top, 12)
        
                            HStack {
                                ZStack {
                                    TextField(text: $userInputProductCount, label: {
                                        Text("개수가 몇 개냐?")
                                            .foregroundColor(.gray)
                                    })
                                    .font(.custom("ChosunCentennial", size: 20))
                                    .frame(width: 133, height: 25)
                                    .focused($focusedField, equals: .userCount)
                                    .keyboardType(.numberPad)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            if keyboardText == "결과 보기" {
                                                if userInputProductPrice.isEmpty {
                                                    Button(keyboardText){
                                                        
                                                    }
                                                    .disabled(true)
                                                }else {
                                                    NavigationLink(destination: ShowPriceView(priceManager: priceManager, tempPrice: getUserPrice(userInputProductCount, userInputProductPrice),itemName: $testProductNames[selectedButtonIndex]), label: {
                                                        Text(keyboardText)
                                                            .foregroundColor(.white)
                                                            .frame(width: 800, height: 45)
                                                            .background(.black)
                                                    }).disabled(false)
                                                }
                                            } else if userInputProductCount == "" {
                                                Button(keyboardText){
                                                    
                                                }.disabled(true)
                                            } else {
                                                Button(keyboardText){
                                                    if !userInputProductCount.isEmpty || !userInputProductPrice.isEmpty {
                                                        keyboardText = "결과 보기"
                                                    }
                                                    focusedField = .userPrice
                                                    
                                                }.disabled(false)
                                                    .foregroundColor(.white)
                                                    .frame(width: 800, height: 45)
                                                    .background(.black)
                                            }
                                            
                                        }
                                    }
                                    
                                    Rectangle()
                                        .fill(focusedField == .userCount ? .black : Color("DeactivateTextfieldColor"))
                                        .frame(width: 132, height: 4)
                                        .offset(x: 0, y: 25)
                                }
                                
                                Text("개")
                                    .padding(.leading, 7)
                            }.padding(.top, 32)
        
                            
                            HStack {
                                ZStack {
                                    TextField(text: $userInputProductPrice, label: {
                                        Text("가격이 얼마냐?")
                                            .foregroundColor(.gray)
                                    })
                                    .font(.custom("ChosunCentennial", size: 20))
                                    .frame(width: 133, height: 25)
                                    .focused($focusedField, equals: .userPrice)
                                    .keyboardType(.numberPad)

                                    Rectangle()
                                        .fill(focusedField == .userPrice ? .black : Color("DeactivateTextfieldColor"))
                                        .frame(width: 132, height: 4)
                                        .offset(x: 0, y: 25)
                                }

                                Text("원")
                                    .padding(.leading, 7)
                            }.padding(.top, 61)
                            
                            Spacer(minLength: 140)
                            
                            NavigationLink(destination: ShowPriceView(priceManager: priceManager, tempPrice: getUserPrice(userInputProductCount, userInputProductPrice),itemName: $testProductNames[selectedButtonIndex]), label: {
                                Text("결과 보기")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 56,maxHeight: 56, alignment: .center)
                                    .foregroundColor(.white)
                                    .background(.gray)
                                    .cornerRadius(12)
                                    .padding([.leading, .trailing], 16)
                            })
                            
                            Spacer(minLength: 40)
            
            
                        }
                        .navigationTitle("test").navigationBarTitleDisplayMode(.inline)
                    }
            
        }
        .navigationBarHidden(true)
        .onAppear() {
            focusedField = .userCount
        }
        .onTapGesture {
            focusedField = .none
        }
    }
    
    public func getUserPrice(_ totalAmount: String,  _ totalPrice: String) -> Int{
            guard totalAmount != "", totalPrice != "" else{
                
                return 0
            }
            return Int(totalPrice)! / Int(totalAmount)!
        }
    
    private func clickedProductButton() {
        
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView(priceManager: APIManger())
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
                .font(.custom("ChosunCentennial", size: 20))
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
    let index: Int
    @Binding var selectedButtonIndex: Int
    @Binding var goodCodes: [Int]
    @ObservedObject var priceManager: APIManger
    
    var body: some View {
        Button(action: {
            selectedButtonIndex = index
            priceManager.loadData(goodCodes[selectedButtonIndex])
        }, label: {
            Text("\(productNames[index])")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(selectedButtonIndex == index ? .white : .gray)
                .padding([.leading, .trailing], 14)
                .padding([.top, .bottom], 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(selectedButtonIndex == index ? .black : .gray, lineWidth: 1)
                )
        })
        .id(index)
        .background(selectedButtonIndex == index ? .black : .white)
        .cornerRadius(20)
        .padding(.bottom, 12)
        .padding(.top, 16)
        
    }
}

// 커스텀 네비게이션 바 & 세부 상품 선택 버튼
struct customNavigationBar: View {
    let testProductNames: [String]
    let categoryTitle: String
    
    @Binding var shouldScroll: Bool
    @Binding var contentSize: CGSize
    @Binding var selectedButtonIndex: Int
    @Binding var goodCodes: [Int]
    @ObservedObject var priceManager: APIManger
    
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
                        ForEach(0..<testProductNames.count) { index in
                            SelectProductButton(productNames: testProductNames, index: index, selectedButtonIndex: $selectedButtonIndex, goodCodes: $goodCodes, priceManager: priceManager)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Rectangle().foregroundColor(.white))
                    }
                    .padding([.leading, .trailing], 8)
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
        
            .onAppear{
                priceManager.loadData(goodCodes[selectedButtonIndex])
            }
    }
}

//struct ShowResultButton: View {
//
//
//
//
//    @State var userPrice: Int = 0
//    @State var goodCode: [Int] = []
//
//    @Binding var totalAmount: String
//    @Binding var totalPrice: String
//    @Binding var selectedButtonIndex: Int
//
//    @ObservedObject var priceManager: APIManger
//
//
//
//    public func getUserPrice(_ totalAmount: String,  _ totalPrice: String, _ goodCode : [Int], _ selectedButtonIndex: Int) -> Int{
//        guard totalAmount != "", totalPrice != "" else{
//            return 0
//        }
//        let selectedCode =  goodCode[selectedButtonIndex]
//        self.priceManager.loadData(selectedCode)
//
//        return Int(totalPrice)! / Int(totalAmount)!
//    }
//}
