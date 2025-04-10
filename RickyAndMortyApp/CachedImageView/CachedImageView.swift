//
//  CachedImageView.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 3/30/25.
//

import SwiftUI

struct CachedImageView: View {
    let urlString: String?

    @StateObject private var imageCache = ImageCache()

    var body: some View {
        Group {
            switch imageCache.state {
            case .empty:
                placeHolderImage
            case .loading:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .error:
                errorImage
            }
        }
        .onAppear {
            Task {
                await imageCache.fetchImage(for: urlString ?? "")
            }
        }
    }

    private var placeHolderImage: some View {
        Image(systemName: "photo")
            .font(.title)
            .foregroundStyle(.placeholder)
    }

    private var errorImage: some View {
        Image(systemName: "photo.badge.exclamationmark.fill")
            .font(.title)
            .foregroundStyle(.red)
    }
}
