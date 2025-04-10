//
//  ImageLoadingState.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 3/30/25.
//

import SwiftUI

enum ImageLoadingState {
    case empty
    case loading
    case error(Error)
    case success(Image)
}
