//
//  ContentView.swift
//  ZarinGobi
//
//  Created by Hyung Seo Han on 2022/10/08.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
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
                            FoodButtonView(title: button.title, button: button)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom)
                    
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
