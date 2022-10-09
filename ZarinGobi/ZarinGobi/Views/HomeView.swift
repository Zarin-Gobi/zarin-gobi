//
//  ContentView.swift
//  ZarinGobi
//
//  Created by Hyung Seo Han on 2022/10/08.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @ObservedObject var priceManager = APIManger()
    
    
    let buttons: [FoodButtonName] = [.bab, .ham, .egg, .chamchi, .mandu, .gimJaban, .bongjiRamen, .cola, .water]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .padding(.vertical, -50.0)
                VStack{
                    ZStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("자린고비가")
                                    .background( GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: 0, y: geo.size.height - 10))
                                            path.addLine(to: CGPoint(x: geo.size.width - 45, y: geo.size.height-5))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 20)) // adjust to your liking
                                        //TODO: 언더라인 색상 변경 해야 함
                                        .foregroundColor(Color("zaringobiColor"))
                                    })
                                Text("알려준다")
                            }
                            .font(.custom("ChosunCentennial", size: 48))
                            .position(x: 100, y: 85)
                            .padding(.leading, 31)
                            
                            Spacer()
                        }
                        Image("HomeViewImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, -10)
                    }
                    
                    LazyVGrid(columns: columns) {
                        ForEach(buttons, id: \.self) { button in
                            NavigationLink {
                                AmountInputView(goodCodes: button.codes, priceManager: self.priceManager, testProductNames: button.goodName, categoryTitle: button.title)
                            } label: {
                                FoodButtonView(title: button.title, button: button)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom)
                    
                }
            }.navigationBarHidden(true)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
