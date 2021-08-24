//
//  LiveMedicallView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI

struct VideoView: View {
    var bgColor: Color
    var videoProcessor:VideoProcessor
    
    @State var videoFrame: UIImage = UIImage(imageLiteralResourceName: "Heart-icon")
    
    init( bgColor:Color, videoDelegate:VideoProcessor ){
        self.bgColor = bgColor
        self.videoProcessor = videoDelegate
    }
    var body: some View {
        VStack{
           Image(uiImage:videoFrame )
            .resizable()
//            .aspectRatio(0.75, contentMode: .fill)
//            .aspectRatio(1, contentMode: .fill)
            .onAppear(perform: fixupVideoFrame)
        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    private func fixupVideoFrame(){
        videoProcessor.videoView = self
    }
}

