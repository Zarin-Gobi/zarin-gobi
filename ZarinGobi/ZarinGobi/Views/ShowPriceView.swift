//
//  ShowPriceView.swift
//  ZarinGobi
//
//  Created by Eunbi Han on 2022/10/08.
//

import SwiftUI


struct ShowPriceView: View {
    
    
    
    // 임시 최소 최대값
    var tempLowPrice: Int = 1000
    var tempHighPrice: Int = 10000
    
    // 임시 받아온 값
    var tempPrice: Int = 7000
    var body: some View {
        GeometryReader { geo in
            
            // 화면 width와 height 잡기
            let viewWidth = geo.size.width
            let viewHeight = geo.size.height
            // MARK: - 전체 V스택
            VStack(alignment: .leading){
                
                // MARK: - 1번째 부분
                VStack(alignment: .leading, spacing: viewHeight*0.023){
                    // 가격 기준 설명
                    Text("지금 가격은 1개 당...")
                        .foregroundColor(.descriptionGray)
                        .font(.system(size: 16, weight: .medium))
                    
                    // 가격
                    VStack(alignment: .leading, spacing: viewHeight*0.023){
                        // 최소가격
                        HStack(alignment: .center, spacing: 14){
                            Text("최소")
                                .font(.system(size: 24, weight: .medium))
                            
                            Text("\(tempLowPrice)원")
                                .font(.system(size: 36,weight: .bold))
                                .background( GeometryReader { geo in
                                    Path { path in
                                        path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                        path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height-5))
                                    }
                                    .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                    .foregroundColor(.underBarGray)
                                })
                            
                        }
                        // 최대가격
                        HStack(alignment: .center,spacing: 14){
                            Text("최대")
                                .font(.system(size: 24, weight: .medium))
                            
                            
                            Text("\(tempHighPrice)원")
                                .font(.system(size: 36,weight: .bold))
                                .background( GeometryReader { geo in
                                    Path { path in
                                        path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                        path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height-5))
                                    }
                                    .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                    .foregroundColor(.underBarGray)
                                })
                            
                        }
                    }
                }
                Spacer(minLength: viewHeight*0.03)//minLength: viewHeight*0.067)
                // MARK: - 2번째 세션
                VStack(alignment: .leading, spacing: viewHeight*0.028){
                    Text("내 물품의 가격의 위치는...")
                        .foregroundColor(.descriptionGray)
                        .font(.system(size: 16, weight: .medium))
                    
                    //percentage = (value - min) / (max - min)
                    let percentage = CGFloat(tempPrice-tempLowPrice)/CGFloat(tempHighPrice-tempLowPrice)
                    
                    // 누워있는 바차트
                    ZStack{
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: viewWidth * 0.91,height: 30)
                                .foregroundColor(.barBaseGray)
                            RoundedRectangle(cornerRadius: 16)
                                .overlay((LinearGradient(colors: [.firstBarColor, .lastBarColor], startPoint: .leading, endPoint: .trailing)))
                                .cornerRadius(16)
                                .frame(width: viewWidth * 0.91 * percentage, height: 30)
                            
                            
                        }
                        HStack(alignment: .center, spacing: viewWidth * 0.91 * 0.79) {
                            Text("최소")
                                .foregroundColor(.white)
                            Text("최대")
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer(minLength: viewHeight*0.085)
                VStack(alignment: .leading, spacing: viewHeight*0.029){
                    HStack{
                        Text("에잉 쯧,")
                        Text("안 사!")
                            .background( GeometryReader { geo in
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: geo.size.height-5))
                                    path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height-5))
                                }
                                .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                .foregroundColor(.underBarGray)
                            })
                    }.font(.system(size: 36, weight: .bold))
                    
                    Image("zaringobi")
                        .resizable()
                        .frame(width: viewWidth*0.91, height: viewHeight*0.42)
                        .padding(.bottom,50)
                    
                }
                
                
                
            }.padding(.all)
        }
    }
}

struct ShowPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPriceView()
    }
}

// MARK: - 임시 컬러 익스텐션
extension Color {
    public static var descriptionGray: Color {
        return Color(uiColor: UIColor(red: 149/255, green: 149/255, blue: 149/255, alpha: 1.0))
    }
    public static var underBarGray: Color {
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
