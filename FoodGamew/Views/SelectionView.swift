//
//  SelectionView.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/20/24.
//

import SwiftUI

struct SelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var transportSelection: Transport = .car
    @State private var selectedCount: Int = 0
    @State var priceExluded: Int = 0
    
    var body: some View {
        
        VStack{
            header()
            Spacer()
            
            Text("Select Price Range")
                .font(.system(size: 25, weight:.bold))
                .foregroundColor(.black)
            PriceSelectionView(selectedCount:$selectedCount, priceExluded: $priceExluded).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            Text("I am")
                .font(.system(size: 25, weight:.bold))
                .foregroundColor(.black)
            
            Picker("Transport", selection: $transportSelection) {
                Image(systemName: "figure.walk").tag(Transport.walk)
                Image(systemName: "car.fill").tag(Transport.car)
                Image(systemName: "bus").tag(Transport.bus)
            }.pickerStyle(.segmented)
                .padding(EdgeInsets(top:0,leading:40,bottom:0,trailing:40))
            
            Spacer()
            Button{
                
            }label:{
                Text("Begin Game")
                    .frame(width: 250,height: 100)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .font(.system(size: 30,weight: .bold))
                    .cornerRadius(15)
            }
            Spacer()
        
        }.navigationBarBackButtonHidden(true)
            .toolbar {
                //
                ToolbarItem(placement: .navigationBarLeading) {

                    Button {
                        // 3
                        print("Custom Action")
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
        Text("Would You Rather")
            .frame(width: UIScreen.main.bounds.width, height: 30)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .background(LinearGradient(gradient: Gradient(colors: [Color.red,Color.indigo,Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .font(.system(size: 25, weight:.bold))

            
            
    }
}

struct PriceSelectionView: View {
    @Binding var selectedCount: Int
    @Binding var priceExluded: Int
    var body: some View {
        HStack {
            ForEach(1...4, id: \.self) { index in
                
                Image(systemName: "dollarsign")
                    .font(.system(size: 30))
                    .foregroundColor(self.isSelected(index: index) ? .blue : .gray)
                    .gesture(
                        TapGesture(count: 2)
                            .onEnded({
                                self.priceExluded = index
                                
                                print("Double Tap")
                            })
                            .exclusively(before:
                                TapGesture()
                                .onEnded({
                                    self.selectedCount = index
                                    self.priceExluded = 0
                                })
                        )
                    )
            }
        }
    }
    private func isSelected(index: Int) -> Bool {
        if(priceExluded > 0){
            print(index <= selectedCount && index > priceExluded)
            return index <= selectedCount && index > priceExluded
        }
        return index <= selectedCount
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


