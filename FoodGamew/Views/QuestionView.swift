//
//  QuestionView.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var network: Network
    
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        VStack{
            header()
            if(!network.gameOver){
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
            
        }.navigationBarBackButtonHidden(true)
        
        
    }//end of body
}

#Preview {
    QuestionView()
}
