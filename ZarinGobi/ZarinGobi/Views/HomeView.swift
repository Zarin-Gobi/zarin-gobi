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
                HStack{
                    VStack(alignment: .leading){
                        Text("자린고비가")
                        Text("알려준다")
                    }
                    .font(.system(size: 48, weight: .bold))
                    .padding(31)
                    
                    Spacer()
                    
                    //TODO: 매달린 자린고비 Image
                    //Image(named: ??)
                }
                
                //TODO: - 자린고비 이미지
                //Image(named: ??)
                
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
