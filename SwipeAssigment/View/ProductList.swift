//
//  ProductList.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/10/24.
//

//    private var filteredProducts: [Product] {
//           guard !searchText.isEmpty else {
//               return productModel.products
//           }
//
//           return productModel.products.filter { product in
//               product.product_name.lowercased().contains(searchText.lowercased()) ||
//               product.product_type.lowercased().contains(searchText.lowercased())
//           }
//       }


import Foundation
import SwiftUI
import SwiftData

// SwiftUI View to display products

struct ProductList: View {
    
    @State private var isAddProduct : Bool = false
    
    @StateObject private var productModel = ProductViewModel()
    @State private var searchText: String = ""
    @State private var currentPage = 1
    @State private var filteredByInterested  = false
    
    private let itemsPerPage = 10

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
 
     private func applySearchFilter(_ products: [Product]) -> [Product] {
         guard !searchText.isEmpty else { return products }
         return products.filter { product in
             product.product_name.lowercased().contains(searchText.lowercased()) ||
             product.product_type.lowercased().contains(searchText.lowercased())
         }
     }
     
   
    private func applyFavoriteFilter(_ products: [Product]) -> [Product] {
        guard filteredByInterested else { return products }
        return products.filter { $0.isFavorite }
    }

     
     private var filteredProducts: [Product] {
         let searchFiltered = applySearchFilter(productModel.products)
         let favoriteFiltered = applyFavoriteFilter(searchFiltered)
         return favoriteFiltered
     }
     
     private var paginatedProducts: [Product] {
         Array(filteredProducts.prefix(currentPage * itemsPerPage))
     }

    
    var body: some View {
     
        NavigationView {
            VStack {
                
                // Product Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(paginatedProducts) { product in
                            ProductView(
                                isFavorite: .constant(product.isFavorite),
                                imageURL: product.image ?? "",
                                productName: product.product_name,
                                productPrice: product.twoDecimals(number: Float(product.price)),
                                tax: Int(product.tax),
                                productCategory: product.product_type,
                                    onFavoriteToggle: {
                                        productModel.toggleFavorite(for: product.id)
                                    }
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
                        isAddProduct.toggle()
                    }
                    .tint(.black)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button( "Filter",systemImage:
                                filteredByInterested ?
                            "star.fill" : "star"){
                        
                        withAnimation {
                            filteredByInterested.toggle()
                        }
                        
                    }
                            .tint(filteredByInterested ? Color.black : .black)
                }
            }
            .sheet(isPresented: $isAddProduct) {
                
                AddProductView(isAddProduct: $isAddProduct)
             
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
