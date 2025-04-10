//
//  ImageCache.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 3/30/25.
//

import SwiftUI

@MainActor
class ImageCache: ObservableObject {
    @Published var state: ImageLoadingState = .empty

    /// A dedicated shared cache for storing cached images.
    ///
    /// This is configured with much greater capacity than the default URLCache.shared and
    /// allows us to store cached images to disk storage.
    private static let cache: URLCache = {
        let memoryCapacity = 100 * 1024 * 1024 // 100 MB
        let diskCapacity = 500 * 1024 * 1024 // 500 MB
        return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imagesCache")
    }()

    func fetchImage(for urlString: String) async {
        if urlString.isEmpty {
            state = .empty
            return
        }

        guard let url = URL(string: urlString) else {
            state = .error(URLError(.badURL))
#if DEBUG
            print("ImageCache: Malformed url: \(urlString)")
#endif
            return
        }

        // Let's first see if this url exists in the cache..
        if let cachedResponse = ImageCache.cache.cachedResponse(for: URLRequest(url: url)),
           let cachedImage = UIImage(data: cachedResponse.data) {
#if DEBUG
            print("ImageCache: Cache hit (\(url.absoluteString))")
#endif
            state = .success(Image(uiImage: cachedImage))
            return
        }

        // Let's try to download this image from the network..
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                throw URLError(.badServerResponse)
            }

            if let image = UIImage(data: data) {
                // Add this url to the cache
                let cachedResponse = CachedURLResponse(response: response, data: data)
                ImageCache.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
#if DEBUG
                print("ImageCache: Downloaded (\(url.absoluteString))")
#endif
                state = .success(Image(uiImage: image))
            } else {
                print("ImageCache: Decode Error (\(url.absoluteString))")
                throw URLError(.cannotDecodeContentData)
            }
        } catch {
#if DEBUG
            print("ImageCache: Error (\(url.absoluteString))")
#endif
            state = .error(error)
        }
    }
}
