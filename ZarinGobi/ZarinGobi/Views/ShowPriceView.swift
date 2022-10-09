//
//  ShowPriceView.swift
//  ZarinGobi
//
//  Created by Eunbi Han on 2022/10/08.
//

import SwiftUI


struct ShowPriceView: View {
    
    
    @ObservedObject var priceManager: APIManger

    @State var tempPrice: Int = 0
    // 임시 최소 최대값
    @State var tempLowPrice: Int = 0
    @State var tempHighPrice: Int = 0
    
    @Binding var itemName: String
    
    // 임시 받아온 값
    
    var body: some View {
        GeometryReader { geo in
            
            // 화면 width와 height 잡기
            let viewWidth = geo.size.width
            let viewHeight = geo.size.height
            
            VStack() {
                CustomNavigationBar(categoryTitle: itemName)
                    .frame(width: viewWidth)
                // MARK: - 전체 V스택
                VStack(alignment: .leading) {
                    // MARK: - 1번째 부분
                    VStack(alignment: .leading, spacing: viewHeight*0.023){
                        // 가격 기준 설명
                        Text("이 물품의 시세는 1개 당...")
                            .foregroundColor(.descriptionGray)
                            .font(.system(size: 16, weight: .medium))
                        
                        // 가격
                        HStack(alignment: .center, spacing: viewWidth*0.14  ){
                            // 최소가격
                            VStack(alignment: .leading, spacing: 14){
                                Text("최소")
                                    .font(.custom("ChosunCentennial", size: 24))
                                
                                Text("\(tempLowPrice)원")
                                    .font(.custom("ChosunCentennial", size: 36))
                                    .background( GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height-5))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                        .foregroundColor(.underBarYellow)
                                    })
                                
                            }
                            // 최대가격
                            VStack(alignment: .leading,spacing: 14){
                                Text("최대")
                                    .font(.custom("ChosunCentennial", size: 24))
                                
                                
                                Text("\(tempHighPrice)원")
                                    .font(.custom("ChosunCentennial", size: 36))
                                    .background( GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height-5))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                        .foregroundColor(.underBarYellow)
                                    })
                                
                            }
                        }
                    }
                    
                    Spacer(minLength: viewHeight*0.07)//minLength: viewHeight*0.067)
                    
                    
                    // MARK: - 2번째 부분
                    VStack(alignment: .leading, spacing: viewHeight*0.002){
                        Text("내 물품의 가격은...")
                            .foregroundColor(.descriptionGray)
                            .font(.system(size: 16, weight: .medium))
                        
                        //화살표와
                        VStack(alignment: .center){
                            //percentage = (value - min) / (max - min)
                            let percentage = CGFloat(tempPrice-tempLowPrice)/CGFloat(tempHighPrice-tempLowPrice)
                            if percentage <= 0.5 {
                                Triangle()
                                    .fill(Color.underBarYellow).opacity(0.5)
                                    .frame(width:29,height: 29)
                                    .offset(x:max(viewWidth*0.91*(percentage-0.5),-viewWidth*0.91*0.5-15))
                            } else {
                                Triangle()
                                    .fill(Color.triangleYellow)
                                    .frame(width:29,height: 29)
                                .offset(x:min(viewWidth*0.91*(percentage-0.5)-15,viewWidth*0.91*0.5-15))                        }
                            Image("Line")
                            HStack(alignment: .center, spacing: viewWidth*0.75) {
                                Text("싼 거")
                                    .font(.custom("ChosunCentennial", size: 14))
                                Text("비싼 거")
                                    .font(.custom("ChosunCentennial", size: 14))
                            }
                        }
                    }
                    Spacer(minLength: viewHeight*0.055)
                    // dfadfdfd
                    // MARK: - 3번째 부분
                    VStack(alignment: .leading, spacing: viewHeight*0.029){
                        let percentage = CGFloat(tempPrice-tempLowPrice)/CGFloat(tempHighPrice-tempLowPrice)
                        HStack{
                            if percentage >= 0.7 {
                                Text("에잉 쯧,")
                                Text("안 사!")
                                    .background( GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height-5))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                        .foregroundColor(.NopeUnderBarColor)
                                    })
                            } else if percentage <= 0.3{
                                Text("당장")
                                Text("사자!")
                                    .background(GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                            path.addLine(to:CGPoint(x: geo.size.width, y: geo.size.height-5))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 20))
                                        .foregroundColor(.BuyUnderBarColor)
                                    })
                                Text("쟁여!")
                            } else {
                                Text("음, 그럭저럭...")
                            }
                        }.font(.custom("ChosunCentennial", size: 36))
                        
                        if percentage >= 0.7 {
                            Image("nope")
                                .resizable()
                                .frame(width: viewWidth*0.91, height: viewHeight*0.42)
                                .padding(.bottom,50)
                        } else if percentage <= 0.3{
                            Image("soso")
                                .resizable()
                                .frame(width: viewWidth*0.91, height: viewHeight*0.42)
                                .padding(.bottom,50)
                        } else {
                            Image("buy")
                                .resizable()
                                .frame(width: viewWidth*0.91, height: viewHeight*0.42)
                                .padding(.bottom,50)
                        }
                        
                    }
                }
                .navigationBarHidden(true)
            }
        }
        
        .onAppear{
            self.tempLowPrice = priceManager.lowestPrice
            self.tempHighPrice = priceManager.hightestPrice
        }
    }
}

struct ShowPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPriceView(priceManager: APIManger(),itemName: .constant("사조참치") )
    }
}

// MARK: - 임시 컬러 익스텐션
extension Color {
    public static var descriptionGray: Color {
        return Color(uiColor: UIColor(red: 149/255, green: 149/255, blue: 149/255, alpha: 1.0))
    }
    public static var underBarYellow: Color {
        return Color(uiColor: UIColor(red: 232/255, green: 161/255, blue: 0/255, alpha: 0.3))
    }
    public static var barBaseGray: Color {
        return Color(uiColor: UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0))
    }
    public static var firstBarColor: Color {
        return Color(uiColor: UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0))
    }
    public static var lastBarColor: Color {
        return Color(uiColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0))
    }
    public static var BuyUnderBarColor: Color {
        return Color(uiColor: UIColor(red: 81/255, green: 150/255, blue: 255/255, alpha: 0.3))
    }
    public static var NopeUnderBarColor: Color {
        return Color(uiColor: UIColor(red: 255/255, green: 102/255, blue: 81/255, alpha: 0.3))
    }
    public static var triangleYellow: Color {
        return Color(uiColor: UIColor(red: 232/255, green: 161/255, blue: 0/255, alpha: 0.5))
    }
    
}

// MARK: - 텍스트 언더라인 밑줄
struct UnderlinedText: View {
    
    var text: String
    var underlinePadding: CGFloat
    
    var body: some View {
        VStack (spacing: underlinePadding) {
            Text(text)
            GeometryReader { proxy in
                Rectangle()
                    .frame(width: proxy.size.width, height: 1)
            }
        }
    }
}
// MARK: - 삼각형 모양
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let line = rect.height  //루트3
        let r = (line/sqrt(3))    // 절반 1
        
        path.move(to: CGPoint(x: rect.midX-r, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX+r, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX-r, y: rect.minY))
        
        return path
    }
}



//custom navigation bar
struct CustomNavigationBar: View {
    
    let categoryTitle: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
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
        
    }
}
