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
      
    
    init() {
        fetchProducts()
    }
    
    func toggleFavorite(for productId: UUID) {
          if let index = products.firstIndex(where: { $0.id == productId }) {
              // This will automatically update UserDefaults through the computed property

              products[index].isFavorite.toggle()
                          // Save the new status in UserDefaults
                          products[index].setFavorite(products[index].isFavorite)
                          objectWillChange.send()
          }
      }
//    
    private func saveFavoriteStatus(productId: UUID, isFavorite: Bool) {
         UserDefaults.standard.set(isFavorite, forKey: "favorite_\(productId)")
     }
     
     private func loadFavoriteStatus(productId: UUID) -> Bool {
         return UserDefaults.standard.bool(forKey: "favorite_\(productId)")
     }
     
    
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
