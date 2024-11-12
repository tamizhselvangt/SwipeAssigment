//
//  ProductViewModel.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/11/24.
//


import Foundation
import SwiftData

// ViewModel to manage products
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
       private var allProducts: [Product] = []
    
    init() {
        fetchProducts()
    }
    
//    func toggleFavorite(for product: Product) {
//          var updatedProduct = product
////          updatedProduct.isFavorite.toggle()
//          
//          if let index = products.firstIndex(where: { $0.id == product.id }) {
//              products[index] = updatedProduct
//          }
//      }
    
    func fetchProducts() {
        guard let url = URL(string: "https://app.getswipe.in/api/public/get") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedProducts = try JSONDecoder().decode([ProductResponse].self, from: data)
                    
                    // Convert to Product models and update the products array
                    DispatchQueue.main.async {
                        self.products = decodedProducts.map { productResponse in
                            Product(
                                image: productResponse.image,
                                price: productResponse.price,
                                product_name: productResponse.product_name,
                                product_type: productResponse.product_type,
                                tax: productResponse.tax
                            )
                        }
                    }
                } catch {
                    print("Error decoding products: \(error)")
                }
            }
        }.resume()
        
    }
}
