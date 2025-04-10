//
//  CharacterListRow.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import SwiftUI

struct CharacterListRow: View {
    @State var character: RickyAndMortyResult
    
    var body: some View {
        HStack {
            VStack {
                Text(character.name)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(character.species ?? "")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            CachedImageView(urlString: character.image)
                .frame(width: 64, height: 64)
                .cornerRadius(5)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            CharacterListRow(character: RickyAndMortyResult.sample)
        }
    }
}
