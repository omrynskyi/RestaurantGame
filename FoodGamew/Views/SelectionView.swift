//
//  SelectionView.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/20/24.
//

import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var network: Network
    var userRadius: Double = 5
    var longitude: Double = 0
    var latitude: Double = 0
    @State var priceLimit: [Int] = []
    @State private var selectedCount: Int = 0
    @State var priceExluded: Int = 0
    
    
    
    
    
    @Environment(\.dismiss) private var dismiss
    @State var transportSelection: Transport = .car


   
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                header()
                Spacer()
                Text("Select Price Range")
                    .font(.system(size: 20, weight:.bold))
                    .foregroundColor(.primary)
                PriceSelectionView(selectedCount:$selectedCount, priceExluded: $priceExluded, priceArr: $priceLimit).padding(EdgeInsets(top: 1, leading: 0, bottom: 7, trailing: 0))
                Spacer()
                
                
                Text("I am")
                    .font(.system(size: 25, weight:.bold))
                    .foregroundColor(.primary)
                
                Picker("Transport", selection: $transportSelection) {
                    Image(systemName: "figure.walk").tag(Transport.walk)
                    Image(systemName: "car.fill").tag(Transport.car)
                    Image(systemName: "bus").tag(Transport.bus)
                }.pickerStyle(.segmented)
                    .padding(EdgeInsets(top:0,leading:40,bottom:0,trailing:40))
                
                Spacer()
                NavigationLink{
                    QuestionView(userRadius: self.userRadius, longitude: self.longitude, latitude: self.latitude, priceLimit: priceLimit).environmentObject(network)
                    
                }
            label:{
                   
                Text("Begin Game")
                    .frame(width: 250,height: 100)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .font(.system(size: 30,weight: .bold))
                    .cornerRadius(15)
                    
                }
                    
                Spacer()
            
            }
        }.onAppear {
            
            
            
        }.navigationBarBackButtonHidden(true)
            .toolbar {
                //
                ToolbarItem(placement: .navigationBarLeading) {

                    Button {
                        dismiss()
                    } label: {
                        // 4
                        HStack {

                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                        }
                    }
                }
        }
    }
    //end of body


}
struct header: View {
    var body: some View {
        Text("This Or That")
            .frame(width: UIScreen.main.bounds.width, height: 30)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .background(LinearGradient(gradient: Gradient(colors: [Color.green,Color.blue,Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .font(.system(size: 25, weight:.bold))

            
            
    }
}

enum Transport: String, CaseIterable {
    case walk
    case car
    case bus
}

struct SelectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectionView()
.previewInterfaceOrientation(.portrait)
    }
}


