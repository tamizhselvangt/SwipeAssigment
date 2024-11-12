//
//  AddProductView.swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/11/24.
//

import SwiftUI

struct AlertMessage: Identifiable {
    let id = UUID()
    let message: String
}

struct AddProductView: View {
    
    @StateObject private var viewModel = AddProductViewModel()
    
    
    @State private var showImagePicker = false
    
    @State private var alertMessage: AlertMessage? // for handling alerts

    @Binding var isAddProduct: Bool// for handling sheet appearance
    
    
    //Detect the Theme
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Product Details")
                        .foregroundStyle(colorScheme == .dark ? .white : .gray)
                    ) {
                        TextField("Product Name", text: $viewModel.productName)
                        
                        TextField("Product Type", text: $viewModel.productType)
                        TextField("Price", text: $viewModel.price)
                            .keyboardType(.decimalPad)
                        TextField("Tax", text: $viewModel.tax)
                            .keyboardType(.decimalPad)
                    }

                    // Product Image Selection Section
                    Section(header: Text("Product Image")
                        .foregroundStyle(colorScheme == .dark ? .white : .gray)
                    ) {
                        if let image = viewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Text("No Image Selected")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.gray)
                        }

                        //Select Image Button
                        HStack(alignment: .center){
                            Spacer()
                            Button("Select Image") {
                                showImagePicker = true
                            }
                            .tint(colorScheme == .dark ? .white :  .black)
                            
                            Spacer()
                        }
                    }//Product Image Section
          

                    // Submit Product Button
                    Button(action: {
                        viewModel.submitProduct()
                        alertMessage = AlertMessage(message: (viewModel.successMessage ?? viewModel.errorMessage) ?? "Product Uploaded Successfully")
                        
                        isAddProduct.toggle()
                 
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                            }
                            Text("Submit Product")
                        }
                    }
                    .tint(colorScheme == .dark ? .white : .black)
                   
                    .alert(item: $alertMessage) { message in
                        Alert(title: Text(message.message), dismissButton: .default(Text("OK")))
                    }
                    .disabled(!viewModel.isFormValid)
                }//:Form
            } //:VStack
            .navigationTitle("Add Product")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $viewModel.selectedImage)
            }
            .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isAddProduct.toggle()
                    }
                    .tint(colorScheme == .dark ? .white :  .black)
                  }//ToolBar Item Done Button
            }//:ToolBar
        }//:NavigationView
    }
}

// Image picker 
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
    @Previewable @State var addProduct: Bool = true
    AddProductView(isAddProduct: $addProduct)
}
