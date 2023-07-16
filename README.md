# Movie Application (iOS Swift)

This is an iOS Swift movie application that allows users to browse and explore movies. It utilizes various features and libraries to enhance the user experience. The following sections outline the application's key features and the pods used in its development.

## Features

### Movie List Page

- Display a list of movie genres horizontally.
- Show a list of movies based on the selected genre.

### Movie by Genre Page

- View movies filtered by a specific genre.

### Movie Detail Page

The movie detail page consists of three tabs:

1. Tab 1: Detail Info
   - Display detailed information about the movie, including genres and an overview.

2. Tab 2: Reviews
   - View reviews related to the movie.

3. Tab 3: Trailers
   - Watch trailers associated with the movie.

## Pods

The following pods were used in the development of this application:

1. Alamofire
   - A widely-used networking library for handling HTTP requests and responses.

2. SDWebImage
   - An asynchronous image loading and caching library that simplifies image handling in the application.

3. SnapKit
   - A Swift Autolayout DSL (Domain-Specific Language) that enables easy and concise UI layout management.

4. NVActivityIndicatorView/Extended
   - A collection of loading indicators to provide visual feedback during data retrieval or processing.

## Installation

To run this application locally, please follow these steps:

1. Clone the repository:

   ```shell
   git clone https://github.com/your-repo-link.git
2. Install the required pods. Open a terminal window, navigate to the project's directory, and run:
  ```shell
  pod install
3. Open the Xcode workspace (MovieApp.xcworkspace).
4. Build and run the application on the desired simulator or device.

