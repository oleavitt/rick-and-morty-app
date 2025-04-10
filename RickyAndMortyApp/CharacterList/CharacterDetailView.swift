//
//  CharacterDetailView.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @State var character: RickyAndMortyResult

    var body: some View {
        ScrollView {
            CachedImageView(urlString: character.image)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            detailRow("species", character.species)
            detailRow("status", character.status)
            detailRow("origin", character.origin?.name)
        }
        .padding(.horizontal)
        .navigationTitle(character.name)
    }

    private func detailRow(_ title: LocalizedStringKey, _ detail: String?) -> some View {
        HStack {
            Text(title)
            Text(detail ?? "")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(character: RickyAndMortyResult.sample)
    }
}
