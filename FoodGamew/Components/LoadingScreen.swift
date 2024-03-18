//
//  Loading Screen.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 3/18/24.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var degree:Int = 270
    @State private var spinnerLength = 0.6
    var body: some View {
        
        ZStack {
            Rectangle().ignoresSafeArea()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.green,Color.blue,Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack {
                Text("Loading Content Please Wait")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .padding(20)
                Circle()
                    .trim(from: 0.0,to: spinnerLength)
                    .stroke(.white,style: StrokeStyle(lineWidth: 8.0,lineCap: .round,lineJoin:.round))
                    .animation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true))
                    .frame(width: 60,height: 60)
                    .rotationEffect(Angle(degrees: Double(degree)))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .onAppear{
                        degree = 270 + 360
                        spinnerLength = 0
                    }
            }
            
        }
        


    }
}

#Preview {
    LoadingScreen()
}
