//
//  ProductView.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/10/24.
//

import SwiftUI

struct ProductView: View {
    
    @State var isFavorite: Bool = false
    @State var imageURL : String
    @State var productName: String
    @State var productPrice: String
    @State var tax: Int
    @State var productCategory: String
    
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
                                Image(systemName: "photo.fill")
                                    .padding()
                                Text("Product Image")
                                    .font(.title2)
                                    .foregroundStyle(.gray.opacity(0.7))
                                    .fontWeight(.semibold)
                                
                            }
                            .frame(width: width, height: 200)
                            .clipped()
//                            .cornerRadius(10)
                        }
                        .background(
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.4))
                                .cornerRadius(10)
                        )
                        
                        
                        
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title3)
                            .foregroundStyle(isFavorite ? .red : .white)
                            .padding(.all, 8)
                            .shadow(color: .white ,radius: 50)
                            .background(
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.6))
                                    .cornerRadius(100)
                            )
                            .overlay(
                                Image(systemName:  "heart")
                                    .font(.title2)
                                    .fontWeight(.thin)
                                    .foregroundStyle(isFavorite ? .white : .clear)
                            )
                            .padding()
                            .onTapGesture {
                                isFavorite.toggle()
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
    
    @Previewable @State var isFavorite: Bool = false
    ProductView(
//        isFavorite: $isFavorite,
        imageURL: "https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731337255_0_image.jpg", productName: "iPad 6th Gen Refurbished", productPrice: "999.99", tax: 6, productCategory: "Elctronics"
    )
   
}
