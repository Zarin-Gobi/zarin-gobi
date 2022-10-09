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
            VStack{
                ZStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("자린고비가")
                            Text("알려준다")
                        }
                        .font(.system(size: 48, weight: .bold))
                        .position(x: 100, y: 79)
                        .padding(.leading, 31)
                        
                        Spacer()
                    }
                    Image("zaringobi")
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
