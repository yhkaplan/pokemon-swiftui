//
//  ContentView.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import SwiftUI
import Model

public struct ListViewContainer: View {
    @ObservedObject var pokeStore: PokemonListStore // TODO: change action from void

    var isLoading: Bool {
        pokeStore.result.value?.pokemons.isEmpty ?? true
    }

    public init(pokeStore: PokemonListStore) {
        self.pokeStore = pokeStore
    }

    public var body: some View {
        NavigationView {
            if isLoading {
                LoadingView()
            } else {
                ListView(pokemons: pokeStore.result.value?.pokemons ?? []).navigationBarTitle("All Pokemon")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ListViewContainer(
            pokeStore: PokemonListStore(
                initialValue: PokemonPage(),
                publisher: PublisherProvider.publisher(
                    for: PokemonPage.self,
                    url: URL(string: "https://dkfjjf.com")!
                )
            )
        )
    }
}
#endif


// '(@escaping ((Result<[Pokemon], Error>) -> Void) -> Void, @escaping ([Pokemon]?, Error?) -> Void) -> ()' to expected argument type

// '(@escaping (Result<[Pokemon], Error>) -> (), (Optional<Array<Pokemon>>, Optional<Error>) -> ()) -> ()')
