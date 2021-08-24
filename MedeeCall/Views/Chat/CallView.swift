//
//  CallView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI

struct CallView: View {
    @ObservedObject var phoneToWatch = PhoneToWatch()
    
    var body: some View {
        VStack {
            Button(action: {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
                    self.phoneToWatch.updateUI()
                }
            }) {
                Text("Start Live Heart Rate")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            VStack{
                HStack{
                    Text("❤️")
                        .font(.system(size: 50))
                    Spacer()

                }
                
                HStack{
                    Text("\(phoneToWatch.HeartRate)")
                        .fontWeight(.regular)
                        .font(.system(size: 70))
                    
                    Text("BPM")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .padding(.bottom, 28.0)
                    
                    Spacer()
                }
                .onAppear(perform: phoneToWatch.activateSession)

            }
            .padding()
       
        }
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView()
    }
}


