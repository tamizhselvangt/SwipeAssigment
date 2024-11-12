# SwiftUI Product List App - Swipe Technical Assignment

## Overview
This repository contains my implementation of the Product List application for Swipe's technical assessment. The app demonstrates SwiftUI development practices, state management, and local data persistence while maintaining a clean, user-friendly interface.

## Features Implemented

### Core Requirements
- ✓ Product data fetching and display
- ✓ Responsive grid layout using SwiftUI
- ✓ Asynchronous image loading with placeholders
- ✓ Local favorite status persistence
- ✓ Product detail view implementation

### Technical Implementation
- **Architecture**: Follows MVVM pattern
- **UI Framework**: Built with SwiftUI
- **State Management**: Implements proper state handling
- **Data Persistence**: Uses UserDefaults for favorite status
- **Async Operations**: Handles network calls and image loading

## App Structure

### Views
- `ProductListView`: Main view displaying the product grid
- `ProductDetailView`: Detailed view for individual products
- `ProductCardView`: Reusable component for product display

### ViewModels
- `ProductListViewModel`: Manages product data and business logic
- `ProductDetailViewModel`: Handles individual product interactions

### Models
- `Product`: Core data model representing product information
- `ProductResponse`: Decodable model for API responses

## Technical Choices

### SwiftUI
Chosen for:
- Declarative UI syntax
- Built-in state management
- Modern iOS development practices
- Efficient UI updates

### Local Storage
- Implemented using UserDefaults for simplicity
- Maintains favorite status across app launches
- Quick access to saved preferences

## Running the Project

1. Clone the repository:
```bash
git clone https://github.com/yourusername/swipe-assignment.git
```

2. Open in Xcode:
```bash
cd swipe-assignment
open ProductListApp.xcodeproj
```

3. Build and run using Xcode's simulator or a physical device

## Design Decisions

### UI/UX Considerations
- Clean, grid-based layout for optimal product visibility
- Smooth transitions between views
- Clear favorite status indication
- Responsive design that works across iOS devices

### Code Organization
- Separated concerns between data, presentation, and business logic
- Reusable components for consistent UI elements
- Clear naming conventions and code structure

## Potential Enhancements
Given more time, I would consider adding:
- Unit tests for core functionality
- Improved error handling and user feedback
- Pagination for product loading
- Advanced caching mechanisms
- Search and filter capabilities

## Requirements Met
- ✓ SwiftUI implementation
- ✓ Async image loading
- ✓ Local data persistence
- ✓ Clean architecture
- ✓ Error handling
- ✓ Responsive UI

## Contact
For any questions regarding this implementation, please feel free to reach out at tamizhselvanga@gmail.com.

---
This project was created as part of the technical assessment for Swipe.


