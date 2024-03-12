//
//  DisplayResults.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/23/24.
//
import MapKit

import SwiftUI

struct DisplayResults: View {
    var restaurant: Restaurant
   

    
    var body: some View {

        VStack{
            // Fetch Image Data
            
            AsyncImage(url: URL(string: restaurant.image_url)) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 230)
                    .cornerRadius(10)
                    .padding(15)
            } placeholder: {
                Color.blue
            }


            
            Text(restaurant.name)
                .font(.system(size: 25,weight: .bold))

            HStack{
                if(restaurant.price != nil){
                    Text(restaurant.price!)
                        .font(.system(size: 20))
                        .lineSpacing(3)
                }
                
            }.padding(5)
            let _ = print(restaurant.categories)
            ForEach(0...restaurant.categories.count-1, id: \.self) { index in
                Text(restaurant.categories[index].title).foregroundColor(.gray)
            }
            //Image(systemName: "mappin.and.ellipse")
            //    .resizable()
            //    .frame(width: 20, height: 20)
            //   Text("ETA: 5 min")
            // }.foregroundColor(.gray)
            Image("YelpLogo").resizable()
                .scaledToFit()
                .frame(width: 70, height: 30)
                .padding(20)
                .onTapGesture {
                    self.restaurant.openInYelp()
                }
            Spacer()
            HStack{
               
                Button(action: {
                    print("get direction")
                    self.restaurant.openAppleMaps()
                }, label: {
                    CardButton(title:"Get Directions", backColor: .green, frontColor: .white)
                })
            
            }
            Spacer()
            
        }
        .frame(width: 370)
        .background(Color("AccentGray"))
        .cornerRadius(20)
        .padding(20)
            
    
    }
    
}


struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
