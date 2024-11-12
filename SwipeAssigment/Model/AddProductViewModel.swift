//
//  AddProductViewModel.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/11/24.
//


import Foundation


import SwiftUI
import Combine


import Foundation
import SwiftUI
import Combine

class AddProductViewModel: ObservableObject {
    @Published var productName: String = ""
    @Published var productType: String = ""
    @Published var price: String = ""
    @Published var tax: String = ""
    @Published var imageURL: String = ""
    @Published var selectedImage: UIImage?
    @Published var isLoading = false
    @Published var successMessage: String?
    @Published var errorMessage: String?


    // Validate fields before submission
    var isFormValid: Bool {
        guard !productName.isEmpty, !productType.isEmpty,
              let _ = Double(price), let _ = Double(tax) else {
            return false
        }
        return true
    }

    // POST request to submit the product with multipart/form-data
    func submitProduct() {
        guard isFormValid else {
            errorMessage = "Please fill in all fields with valid values."
            return
        }

        // Start loading and clear previous messages
        isLoading = true
        errorMessage = nil
        successMessage = nil

        // Endpoint URL
        guard let url = URL(string: "https://app.getswipe.in/api/public/add") else {
            errorMessage = "Invalid URL."
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Define boundary for multipart form data
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // Create the HTTP body with parameters
        var body = Data()
        
        // Append form fields
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"product_name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(productName)\r\n".data(using: .utf8)!)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"product_type\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(productType)\r\n".data(using: .utf8)!)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"price\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(price)\r\n".data(using: .utf8)!)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"tax\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(tax)\r\n".data(using: .utf8)!)

        // Attach image if selected
        if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"files[]\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        // End boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        // Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                   let data = data {
                    do {
                        // Parse the JSON response
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let success = json["success"] as? Bool, success {
                            self.successMessage = json["message"] as? String ?? "Product added successfully!"
                            self.clearForm()
                        } else {
                            self.errorMessage = "Failed to submit product. Please try again later."
                        }
                    } catch {
                        self.errorMessage = "Failed to parse response."
                    }
                } else {
                    self.errorMessage = "Error: \(response.debugDescription)"
                }
            }
        }.resume()
    }

    // Clear form after successful submission
    private func clearForm() {
        productName = ""
        productType = ""
        price = ""
        tax = ""
        imageURL = ""
        selectedImage = nil
    }
}
