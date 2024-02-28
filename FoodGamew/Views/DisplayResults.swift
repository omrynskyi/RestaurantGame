//
//  DisplayResults.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/23/24.
//

import SwiftUI

struct DisplayResults: View {
    var restaurant: Restaurant
   
    
    var body: some View {
        Spacer()
        VStack{

            // Fetch Image Data
            AsyncImage(url: URL(string: restaurant.image_url))
                .frame(width: 220,height: 180)
                .background(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
                .padding(15)
        
            Text(restaurant.name)
                .font(.system(size: 25,weight: .bold))
            HStack{
                ForEach(0...3, id: \.self) { index in
                    Image(systemName: "dollarsign")
                        .font(.system(size: 20))
                        .padding(-4)
                }
            }.padding(5)
            let _ = print(restaurant.categories)
            ForEach(0...restaurant.categories.count-1, id: \.self) { index in
                Text(restaurant.categories[index].title).foregroundColor(.gray)
            }
            
            //HStack{
                //Image(systemName: "mappin.and.ellipse")
                //    .resizable()
                //    .frame(width: 20, height: 20)
             //   Text("ETA: 5 min")
           // }.foregroundColor(.gray)
            HStack{
                Button{
                    
                    
                }label:{
                    CardButton(title:"Get Direction", backColor: .green, frontColor: .black)
                }
                
            }
        }.frame(width: 300, height: 500)
            .background(Color("AccentGray"))
            .cornerRadius(30)
            
        Spacer()
    }
}

