//
//  ContentView.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import SwiftUI
import Model

public struct ListViewContainer: View {

    @ObservedObject var resource: Resource<PokemonPage>

    public var body: some View {
        NavigationView {
            view(for: resource)
        }
    }

    public init(resource: Resource<PokemonPage>) {
        self.resource = resource
    }

    /// Type-erasing to AnyView is obviously not the best solution...
    func view(for resource: Resource<PokemonPage>) -> AnyView {
        if let result = resource.result {
             switch result {
             case .success(let page):
                 return AnyView(ListView(pokemons: page.pokemons).navigationBarTitle("All Pokemon"))
             case .failure:
                 return AnyView(ErrorView())
             }

         } else {
             return AnyView(LoadingView())
         }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ListViewContainer(resource: Resource(endpoint: pokemonPageEndpoint))
    }
}
#endif
