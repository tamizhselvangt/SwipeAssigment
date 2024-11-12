//
//  ProductView.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/10/24.
//

import SwiftUI

struct ProductView: View {
    
    //Detect the Theme
    @Environment(\.colorScheme) var colorScheme
    
    //Properties in the Product View
    @Binding var isFavorite: Bool
    @State var imageURL : String
    @State var productName: String
    @State var productPrice: String
    @State var tax: Int
    @State var productCategory: String
    
    let onFavoriteToggle: () -> Void
    
    
    
//    var width : CGFloat  = 180
    
    let width : CGFloat = UIScreen.main.bounds.width * 0.45
   
    
    var body: some View {
                
                VStack(alignment: .leading, spacing: 5){
                    //Product Image
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: width , height: 200)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(5)
                        } placeholder: {
                            VStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.largeTitle)
                                    .padding(.bottom,10)
                                    .foregroundStyle(
                                        colorScheme == .dark ? .white.opacity(0.6) :
                                        .black.opacity(0.6))
                                
                                Text("No Product Image")
                                    .font(.title3)
                                    .foregroundStyle(
                                        colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
                                    .fontWeight(.semibold)
                             
                                
                            }
                            .frame(width: width, height: 200)
                            .clipped()
//                            .cornerRadius(10)
                        }
                        .background(
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.3))
                                .cornerRadius(5)
                        )
                        
                        
                        Button(action: {
                            isFavorite.toggle()
                            onFavoriteToggle()
                        }) {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .font(.title3)
                                .foregroundStyle(isFavorite ? .yellow : .white)
                                .padding(.all, 8)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.gray.opacity(0.6))
                                        .cornerRadius(100)
                                )
                                .padding()
                        }

                        
                    }//:ZStack
                    
                    
                    
                    //Product Type
                    Text(productCategory)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            colorScheme == .dark ? .white.opacity(0.6) : .gray)
                        .padding(.leading, 5)
                        .padding(.top, 8)
                        .frame(maxHeight: 20)
                    
                    
                    //Product Name
                    Text(productName)
                        .font(.headline)
                        .frame(maxHeight: 45)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            colorScheme == .dark ? .white : .black)
                        .padding(.leading, 8)
                    
                    
                    //Tax and Price of the Product
                    HStack(spacing: 1){
                        Image(systemName: "percent")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                            .padding(.leading, 8)
                        
                        //Tax amount
                        Text("\(tax)")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(
                                colorScheme == .dark ? .white.opacity(0.9) : .gray.opacity(0.7))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text("$")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                       //Price Amount
                        Text("\(productPrice)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                            .padding(.trailing)
                        
                    }
                    .padding(.bottom)
                    
                    
                    
                    
                    
                    
                }//:VStack
                .background(
                    colorScheme == .dark ?
                    Color.gray.opacity(0.5).edgesIgnoringSafeArea(.all)   .cornerRadius(10) : Color.white.edgesIgnoringSafeArea(.all)
                        .cornerRadius(10)
                )
                .frame(maxWidth: width)
                .padding()
            }
            

        
    
}

#Preview {
    
    @State var isFavorite: Bool = false
    let previewViewModel = ProductViewModel()
    ProductView(
        isFavorite: $isFavorite,
        imageURL: "htts://media.wired.com/photos/670e8085062f39643092bda6/master/w_2240,c_limit/ipad-mini-gear-241015.jpg", productName: "iPad 6th Gen Refurbished", productPrice: "999.99", tax: 6, productCategory: "Elctronics", onFavoriteToggle: {
            
        }
    )
   
}
