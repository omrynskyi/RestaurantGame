//
//  PriceSelectionView.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/29/24.
//

import SwiftUI


struct PriceSelectionView: View {
    @Binding var selectedCount: Int
    @Binding var priceExluded: Int
    @Binding var priceArr: [Int]
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
                                updateArr()
                            })
                            .exclusively(before:
                                TapGesture()
                                .onEnded({
                                    self.selectedCount = index
                                    self.priceExluded = 0
                                    updateArr()
                                })
                        )
                    )
            }
        }
    }
    private func isSelected(index: Int) -> Bool {
        if(priceExluded > 0){
            return index <= selectedCount && index > priceExluded
        }
        updateArr()
        return index <= selectedCount
    }
    
    private func updateArr(){
        var resultArray: [Int] = []
        if(self.selectedCount > 0){
            for index in 1...self.selectedCount{
                if (index <= selectedCount && index > priceExluded){
                    resultArray.append(index)
                }
            }
        }
        priceArr = resultArray

    }
}

