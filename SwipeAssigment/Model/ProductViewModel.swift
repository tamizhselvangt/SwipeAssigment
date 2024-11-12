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
      
    //Every time it calls the api response
    init() {
        fetchProducts()
    }
    
    
    //Select the Favorite
    func toggleFavorite(for productId: UUID) {
          if let index = products.firstIndex(where: { $0.id == productId }) {
            
              products[index].isFavorite.toggle()
                          
                          products[index].setFavorite(products[index].isFavorite)
                          objectWillChange.send()
          }
      }
  
    
    //Save Favorites/Stared Products in UserDefaults
    private func saveFavoriteStatus(productId: UUID, isFavorite: Bool) {
         UserDefaults.standard.set(isFavorite, forKey: "favorite_\(productId)")
     }
     
    
    //Load the Saved Prodycts
     private func loadFavoriteStatus(productId: UUID) -> Bool {
         return UserDefaults.standard.bool(forKey: "favorite_\(productId)")
     }
     
    
    //Fetch Method retrive data from an api 
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
