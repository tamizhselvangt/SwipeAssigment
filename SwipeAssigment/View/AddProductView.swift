//
//  AddProductView.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/11/24.
//

import SwiftUI

struct AlertMessage: Identifiable {
    let id = UUID() // Unique ID for Identifiable conformance
    let message: String
}

struct AddProductView: View {
    @StateObject private var viewModel = AddProductViewModel()
    @State private var showImagePicker = false
    @State private var alertMessage: String? // for handling alerts

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Product Details")) {
                        TextField("Product Name", text: $viewModel.productName)
                        TextField("Product Type", text: $viewModel.productType)
                        TextField("Price", text: $viewModel.price)
                            .keyboardType(.decimalPad)
                        TextField("Tax", text: $viewModel.tax)
                            .keyboardType(.decimalPad)
                    }

                    // Product Image Selection Section
                    Section(header: Text("Product Image")) {
                        if let image = viewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Text("No Image Selected")
                        }

                        Button("Select Image") {
                            showImagePicker = true
                        }
                    }

                    // Submit Product Button
                    Button(action: {
                        viewModel.submitProduct()
                        alertMessage = viewModel.successMessage ?? viewModel.errorMessage // Set alert message on submission
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                            }
                            Text("Submit Product")
                        }
                    }
                    .disabled(!viewModel.isFormValid)
//                    .alert(item: $alertMessage) { message in
//                        Alert(title: Text(message), dismissButton: .default(Text("OK")))
//                    }
//                    .alert(item: $alertMessage) { alert in
//                           Alert(title: Text("alert.message" ), dismissButton: .default(Text("OK")))
//                                       }
                }
            }
            .navigationTitle("Add Product")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $viewModel.selectedImage)
            }
        }
    }
}

// Image picker using UIViewControllerRepresentable
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    AddProductView()
}

//struct AddProductView: View {
//    @StateObject private var viewModel = AddProductViewModel()
//    @State private var showImagePicker = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form {
//                    Section(header: Text("Product Details")) {
//                        TextField("Product Name", text: $viewModel.productName)
//                        
//                        TextField("Product Type", text: $viewModel.productType)
//                        
//                        TextField("Price", text: $viewModel.price)
//                            .keyboardType(.decimalPad)
//                        
//                        TextField("Tax", text: $viewModel.tax)
//                            .keyboardType(.decimalPad)
//                        
//                        TextField("ImageURL", text: $viewModel.imageURL)
//                            
//                    }
//
////                    Section(header: Text("Product Image")) {
////                        if let image = viewModel.selectedImage {
////                            Image(uiImage: image)
////                                .resizable()
////                                .scaledToFit()
////                                .frame(width: 200, height: 200)
////                                .clipShape(RoundedRectangle(cornerRadius: 8))
////                        } else {
////                            Text("No Image Selected")
////                        }
////
////                        Button("Select Image") {
////                            showImagePicker = true
////                        }
////                    }
//
//                    Button(action: {
//                        viewModel.submitProduct()
//                    }) {
//                        HStack {
//                            if viewModel.isLoading {
//                                ProgressView()
//                            }
//                            Text("Submit Product")
//                        }
//                    }
//                    .disabled(!viewModel.isFormValid)
////                    .alert(item: Binding.constant(viewModel.successMessage! ?? viewModel.errorMessage!)) { message in
////                        Alert(title: Text(message), dismissButton: .default(Text("OK")))
////                    }
//                }
//            }
//            .navigationTitle("Add Product")
////            .sheet(isPresented: $showImagePicker) {
////                ImagePicker(selectedImage: $viewModel.selectedImage)
////            }
//        }
//    }
//}
//
//// Image picker using UIViewControllerRepresentable
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//            picker.dismiss(animated: true)
//        }
//    }
//}
//
//
//#Preview {
//    AddProductView()
//}
