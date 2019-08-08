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
    var pokemons: [Pokemon]

    public var body: some View {
        List(pokemons, id: \.name) { pokemon in
            NavigationLink(destination: DetailView(pokemon: pokemon)) {
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

    init(pokemon: Pokemon) {
        viewModel = DetailViewModel(pokemon: pokemon)
    }

    var body: some View {
        VStack {
            Text(viewModel.name)
        }
    }
}

final class DetailViewModel: ObservableObject {

    @Published var name = "-"

    @ObservedObject var pokeStore: PokemonStore

    init(pokemon: Pokemon) {
        self.pokeStore = PokemonStore(pokemon: pokemon)
    }

}
