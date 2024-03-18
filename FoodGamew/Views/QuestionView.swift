//
//  QuestionView.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var network: Network
    var userRadius: Double = 5
    var longitude: Double = 0
    var latitude: Double = 0
    var priceLimit: [Int] = []
    @State var canContinue: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        VStack{
            header()
            if(!canContinue){
                LoadingScreen()
            } else if(!network.gameOver){
                ProgressBar(progress: network.getProgress(), width: 300)
                Spacer()
                Button{
                    network.selectedAnswer(answer: network.currQuestion[0])
                }label: {
                    Question(question: network.currQuestion[0])
                        .foregroundColor(.primary)
                }
                Button{
                    network.selectedAnswer(answer: network.currQuestion[1])
                    
                }label: {
                    Question(question: network.currQuestion[1])
                        .foregroundColor(.primary)
                    
                }
                
                Spacer()
            }else{
                Spacer()
                ScrollView{
                    VStack{
                        ForEach(network.getResult(), id: \.self) { restaurant in
                            DisplayResults(restaurant: restaurant)
                        }
                        
                    }
                    
                }
                
                
                
                
                
                
                Spacer()
            }
            
        }
        .onAppear{
            network.gameStart(longitude: self.longitude, latitude: self.latitude, radius: self.userRadius, price: self.priceLimit, canContinue: $canContinue)
        }.navigationBarBackButtonHidden(true)
        
        
    }//end of body
}

#Preview {
    QuestionView()
}
