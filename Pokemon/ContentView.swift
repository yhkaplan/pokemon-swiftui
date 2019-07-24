//
//  ContentView.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding var pokestore: PokeStore

    var body: some View {
        Text(pokestore.pokemons.last?.name.capitalized ?? "-")
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(pokestore: PokeStore())
    }
}
#endif
