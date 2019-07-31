//
//  ContentView.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import SwiftUI
import Model

public struct ListViewContainer: View {
    @ObservedObject var pokeStore: PokeStore

    var isLoading: Bool { pokeStore.pokemons.isEmpty }

    public init(pokeStore: PokeStore) {
        self.pokeStore = pokeStore
    }

    public var body: some View {
        NavigationView {
            if pokeStore.majorErrorDidOccur {
                ErrorView()
            } else if isLoading {
                LoadingView()
            } else {
                ListView(pokemons: $pokeStore.pokemons).navigationBarTitle("All Pokemon")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ListViewContainer(pokeStore: PokeStore())
    }
}
#endif
