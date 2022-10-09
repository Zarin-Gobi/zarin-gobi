//
//  ZarinGobiApp.swift
//  ZarinGobi
//
//  Created by Hyung Seo Han on 2022/10/08.
//

import SwiftUI

@main
struct ZarinGobiApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ShowPriceView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
