//
//  PrepareView.swift
//  ZarinGobi
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import SwiftUI

struct PrepareView: View {
    @State var categoryName: String = ""
    
    var body: some View {
        VStack{
            CustomNavigationBarforPrepare(categoryTitle: $categoryName)
            Spacer()
            Text("준비중입니다...")
                .font(.custom("ChosunCentennial", size: 48))
                .navigationBarHidden(true)
            Spacer()
        }
    }
}

struct PrepareView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareView()
    }
}

struct CustomNavigationBarforPrepare: View{
    @Binding var categoryTitle: String
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
        }
    }
}
