//
//  ProductView.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/10/24.
//

import SwiftUI

struct ProductView: View {
    
    @Binding var isFavorite: Bool
    @State var imageURL : String
    @State var productName: String
    @State var productPrice: String
    @State var tax: Int
    @State var productCategory: String
    
    let onFavoriteToggle: () -> Void
    
    var width : CGFloat  = 180
    
    var body: some View {
                
                VStack(alignment: .leading, spacing: 5){
                    //Product Image
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: width , height: 200)
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            VStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.largeTitle)
                                    .padding(.bottom,10)
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                Text("No Product Image")
                                    .font(.title3)
                                    .foregroundStyle(.black.opacity(0.6))
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
                        .foregroundStyle(.gray)
                        .padding(.leading, 5)
                        .padding(.top, 8)
                        .frame(maxHeight: 20)
                    
                    
                    //Product Name
                    Text(productName)
                        .font(.headline)
                        .frame(maxHeight: 45)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.leading, 8)
                    
                    
                    HStack(spacing: 1){
                        Image(systemName: "percent")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                            .padding(.leading, 8)
                        
                        Text("\(tax)")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray.opacity(0.7))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text("$")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)

                        Text("\(productPrice)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                            .padding(.trailing)
                        
                    }
                    .padding(.bottom)
                    
                    
                    
                    
                    
                    
                }//:VStack
                .background(
                    Color.white.edgesIgnoringSafeArea(.all)
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
