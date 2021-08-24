//
//  WatchMainView.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2021/02/02.
//

import SwiftUI

struct WatchMainView: View {
    
    let watchToPhone = WatchToPhone()
    
    var body: some View {
        
        MedeeWatchView().onAppear(perform: {
            watchToPhone.activateSession()
        })

    }
}

struct WatchMainView_Previews: PreviewProvider {
    static var previews: some View {
        WatchMainView()
    }
}
