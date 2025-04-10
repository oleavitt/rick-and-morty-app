//
//  CharacterListView.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel(networkLayer: NetworkLayerLive())

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .empty:
                    Text("empty-list")
                case .loading:
                    ProgressView()
                case .error:
                    Text(viewModel.errorMessage)
                case .success:
                    List {
                        ForEach(viewModel.characters, id: \.self) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                CharacterListRow(character: character)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .task {
                await viewModel.fetchCharacters()
            }
            .navigationTitle("characters")
            .searchable(text: $viewModel.name)
            .onChange(of: viewModel.name) {
                Task {
                    await viewModel.fetchCharacters()
                }
            }
        }
    }
}

#Preview {
    CharacterListView()
}
