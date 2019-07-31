//
//  ContentView.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import SwiftUI
import Model
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Self.Context) -> Self.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: Self.UIViewType, context: Self.Context) {
        uiView.startAnimating()
    }

    static func dismantleUIView(_ uiView: Self.UIViewType, coordinator: Self.Coordinator) {
        uiView.stopAnimating()
    }
}

public struct ListViewContainer : View {
    @ObservedObject var pokestore: PokeStore
    var isLoading: Bool { pokestore.pokemons.isEmpty }

    public init(pokestore: PokeStore) {
        self.pokestore = pokestore
    }

    public var body: some View {
        NavigationView {
            if isLoading {
                VStack {
                    ActivityIndicator(style: .large)
                    Text("Loading...")
                }
            } else {
                List(pokestore.pokemons, id: \.name) { pokemon in
                    Text(pokemon.name.capitalized)
                }
                .navigationBarTitle("All Pokemon")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ListViewContainer(pokestore: PokeStore())
    }
}
#endif
