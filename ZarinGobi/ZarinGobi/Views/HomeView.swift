//
//  ContentView.swift
//  ZarinGobi
//
//  Created by Hyung Seo Han on 2022/10/08.
//

import SwiftUI
import CoreData

struct HomeView: View {
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
                        .position(x: 100, y: 100)
                        .padding(.leading, 31)
                        
                        Spacer()
                    }
                    Image("zaringobi")
                        .resizable()
                        
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
