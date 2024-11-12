//
//  ProductList.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/10/24.
//

import Foundation
import SwiftUI
import SwiftData

// SwiftUI View to display products

struct ProductList: View {
    
    @State private var addImage : Bool = false
    
    @StateObject private var productModel = ProductViewModel()
    @State private var searchText: String = ""
    @State private var currentPage = 1
    @State private var filteredByInterested  = false
    
    private let itemsPerPage = 10

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
     
        NavigationView {
            VStack {
                
                // Product Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(productModel.products.prefix(currentPage * itemsPerPage)) { product in
                            ProductView(
                                imageURL: product.image ?? "",
                                productName: product.product_name,
                                productPrice: product.twoDecimals(number: Float(product.price)),
                                tax: Int(product.tax),
                                productCategory: product.product_type
                            )
                            .onAppear {
                                loadMoreProductsIfNeeded(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .refreshable {
                   
                    productModel.fetchProducts()
                    currentPage = 1
                }
                .navigationTitle("Products")
                .searchable(text: $searchText, prompt: "Find a Place")
                .animation(.default, value: searchText)
            }
            .background(Color.gray.opacity(0.1))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Show Images",systemImage: "plus"){
                        addImage.toggle()
                    }
                    .tint(filteredByInterested ? .red : .black)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button( "Filter",systemImage:
                                filteredByInterested ?
                            "heart.fill" : "heart"){
                        
                        withAnimation {
                            filteredByInterested.toggle()
                        }
                        
                    }
                            .tint(filteredByInterested ? .red : .black)
                }
            }
            .sheet(isPresented: $addImage) {
                
                AddProductView()
             
            }
        }
    }
    
    private func loadMoreProductsIfNeeded(product: Product) {
        let thresholdIndex = (currentPage * itemsPerPage) - 3
        if productModel.products.firstIndex(where: { $0.id == product.id }) == thresholdIndex {
            loadMoreProducts()
        }
    }
    
    private func loadMoreProducts() {
        if currentPage * itemsPerPage < productModel.products.count {
            currentPage += 1
        }
    }
}


#Preview {
  ProductList()
}
