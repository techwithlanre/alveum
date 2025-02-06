# Alveum Media Timeline

## Overview

Alveum Media Timeline is a Flutter-based application that displays images and videos fetched from a remote API. To ensure smooth performance and responsiveness, the project implements the following strategies:

- **Parallel API Requests using Future.wait**
- **Advanced Caching Strategy using Hive**
- **Isolates for Non-blocking API Calls**

## Features

### 🚀 Parallel API Requests with Future.wait

Fetching both images and videos simultaneously reduces waiting time and improves overall performance. This is achieved using `Future.wait`, which runs multiple asynchronous operations in parallel:

```dart
await Future.wait([_fetchImages(), _fetchVideos()]);
```

This approach ensures that the app doesn't wait for one API call to finish before starting the next, resulting in faster data retrieval.

---

### 🗂️ Caching Strategy

To optimize performance and reduce redundant network requests, the app uses **Hive** for local storage. The caching strategy is structured as follows:

- Retrieved posts are stored in a Hive box named `posts`.
- When the number of cached posts reaches **50**, the oldest **10 posts** are removed to maintain a manageable cache size.
- This is handled in the `_saveCache()` method:

```dart
void _saveCache() {
  allPosts.map((post) => post.toJson()).toList();
  if (allPosts.length >= 50) {
    allPosts.removeRange(0, 10);
  }
}
```

This ensures that only relevant and recent data is retained while preventing memory overuse.

---

### ⚡ Using Isolates for Non-blocking API Requests

To keep the UI responsive and prevent frame drops, network requests and JSON parsing are offloaded to an **isolate**. This allows the app to execute heavy operations without affecting the main thread:

```dart
List<Post> newPosts = await Isolate.run(() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> hits = data['hits'];
    return hits.map((post) => Post.fromJson(post)).toList();
  }
  return [];
});
```

By using `Isolate.run`, the computationally expensive JSON decoding and API request handling are processed in a separate thread, ensuring a smooth user experience.

---

## 🏗 Project Structure

- **HomeController**:
    - Manages state using GetX.
    - Handles API calls and caching.
    - Uses isolates to process network responses.
    - Prefetches images and videos for seamless scrolling.

- **Hive Caching**:
    - Loads cached posts on startup.
    - Implements a **rolling cache** system to maintain performance.

- **Prefetching**:
    - **Images** are prefetched using `precacheImage`.
    - **Videos** are prefetched by initializing `VideoPlayerController` in advance.

---

## 📌 How to Run the Project

### 1️⃣ Install Dependencies
Make sure you have Flutter installed, then run:
```bash
flutter pub get
```

### 2️⃣ Setup Hive
Ensure Hive is properly set up and initialized in your app. You may need to create a Hive box named `'posts'` before running the app.

### 3️⃣ Run the App
Execute the following command:
```bash
flutter run
```

---

## 🔍 Conclusion

This project showcases best practices for handling media-heavy applications in Flutter. By leveraging:

- **Parallel API requests (`Future.wait`)** for efficiency
- **Optimized caching (`Hive`)** to reduce redundant requests
- **Background processing (`Isolates`)** to keep the UI smooth

---