//
//  ListView.swift
//  UI
//
//  Created by josh on 2019/07/31.
//  Copyright © 2019 josh. All rights reserved.
//

import SwiftUI
import Model


import Combine

public struct ListView: View {
    @Binding var pokemons: [Pokemon]

    public var body: some View {
        List(pokemons, id: \.name) { pokemon in
            NavigationLink(destination: DetailView(url: pokemon.url)) {
                HStack{
                    Image(systemName: "flame") // TODO: represents pokemon type
                    Text(pokemon.name.capitalized)
                }
            }
        }
    }
}

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    @State var showError = false

    init(url: URL?) {
        guard let url = url else { fatalError() }
        viewModel = DetailViewModel(url: url)
    }

    var body: some View {
        Text(viewModel.name)
    }
}

final class DetailViewModel: ObservableObject { // TODO: split up VM and Store

    @Published public var name = "-"


    var pokemon: Pokemon? {
        didSet { // willSet?
            name = pokemon?.name.capitalized ?? ""
        }
    }

    var pokemonCancellable: AnyCancellable?

    init(url: URL) {
        downloadPokemonDetails(url: url)
    }

    // Reference: https://medium.com/@dmytro.anokhin/url-image-view-in-swiftui-f08f85d942d8
    func downloadSpriteImages() { fatalError() }

    func downloadPokemonDetails(url: URL) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        pokemonCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: decoder)
            .sink(receiveCompletion: { result in

            }, receiveValue: { [weak self] pokemon in
                DispatchQueue.main.async {
                    self?.pokemon = pokemon
                }
            })
    }
}
