# Two-Way Paginated List View

## Overview
This Flutter project demonstrates a paginated list view with two-way pagination. The app fetches data dynamically based on the scroll direction, displays a shimmer effect during data loading, and uses a mock API to simulate server responses. The project also follows the MVVM architecture and uses Riverpod for state management.

---

## Features

1. **Two-Way Pagination**:
   - Scroll down to load more items at the bottom.
   - Scroll up to load older items at the top.
   - Ensures no duplicate items in the list.

2. **Shimmer Effect**:
   - Displays shimmer placeholders during data loading at the top or bottom of the list.

3. **Error Handling**:
   - Displays an error message if API calls fail.

4. **Mock API Integration**:
   - Simulates API responses dynamically using `Future.delayed`.
   - Supports pagination with `id` and `direction` parameters.

5. **Architecture**:
   - Follows the MVVM (Model-View-ViewModel) design pattern.
   - Uses **Flutter Riverpod** for state management.

6. **Bonus** (Optional):
   - A search bar to filter the list based on keywords.
   - Highlights matching query text in search results.

---

## Installation

### Prerequisites
- Flutter SDK installed ([Installation Guide](https://docs.flutter.dev/get-started/install))
- Code editor (e.g., Visual Studio Code, Android Studio)
- Device/emulator for testing

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/DarkImpact1/flutterProject.git
   cd flutterProject
   ```
2. Fetch the dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

---

## Folder Structure

```plaintext
lib/
|-- main.dart           # Entry point of the application
|-- models/             # Contains data models (e.g., Item model)
|-- view_models/        # Contains state management logic (e.g., PaginationViewModel)
|-- views/              # Contains UI components (e.g., PaginatedListView)
|-- services/           # Contains the mock API logic
```

---

## API Behavior
The mock API (`mock_api.dart`) simulates server responses with the following behavior:
- Endpoint: `/fetchItems?id=<id>&direction=<direction>`
  - `id`: Either `firstId` or `lastId` based on scroll direction.
  - `direction`: `"up"` or `"down"`.
- Response Format:
  ```json
  {
    "data": [
      {"id": 101, "title": "Item 101"},
      {"id": 102, "title": "Item 102"}
    ],
    "hasMore": true
  }
  ```
- Mocked Data:
  - **Up**: Prepends items with decreasing IDs.
  - **Down**: Appends items with increasing IDs.
  - Stops at predefined limits (e.g., no IDs below 0 or above 2000).

---

## Key Dependencies

1. **Flutter Riverpod**:
   - State management.
   - Handles loading, success, and error states for pagination.

2. **Shimmer**:
   - Provides shimmer loading placeholders.

To install dependencies, run:
```bash
flutter pub get
```

---

## How to Test

1. **Pagination**:
   - Scroll down to fetch more items.
   - Scroll up to fetch older items.

2. **Shimmer Effect**:
   - Observe the shimmer loading effect when new items are being fetched.

3. **Error Handling**:
   - Simulate an error by adding `throw Exception("Simulated error")` in `mock_api.dart` and verify the error message display.


---

## Known Issues
- None currently identified.

---

## Future Enhancements
1. Add persistent storage to cache loaded data.
2. Implement infinite scrolling with lazy loading.
3. Improve UI/UX with animations and better error handling.

---

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-branch-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add new feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-branch-name
   ```
5. Open a pull request.

---

