//
//  ContentView.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import SwiftUI
import Model

public struct ContentView : View {
    @ObservedObject var pokestore: PokeStore

    public init(pokestore: PokeStore) {
        self.pokestore = pokestore
    }

    public var body: some View {
        NavigationView {
            List(pokestore.pokemons, id: \.name) { pokemon in
                Text(pokemon.name.capitalized)
            }
            .navigationBarTitle("All Pokemon")
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(pokestore: PokeStore())
    }
}
#endif
