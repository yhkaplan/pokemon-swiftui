//
//  DetailView.swift
//  UI
//
//  Created by josh on 2019/08/21.
//  Copyright © 2019 josh. All rights reserved.
//

import Model
import SwiftUI
import URLImage

struct DetailView: View {
    @ObservedObject var resource: Resource<Pokemon>

    var pokemon: Pokemon? { resource.result?.value }

    init(pokemon: Pokemon) {
        let endpoint = pokemonEndpoint(pokemon: pokemon)
        self.resource = Resource<Pokemon>(endpoint: endpoint)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(pokemon?.name.capitalized ?? "-")
            .font(.largeTitle)
            pokemon?.sprites?.frontDefault.map {
                URLImage($0) // TODO: make huge
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            }
            Group {
                Text("Stats").font(.title)
                pokemon?.weight.map { Text("Weight: \($0)") }
                pokemon?.height.map { Text("Height: \($0)") }
                pokemon?.baseExperience.map { Text("Base Experience: \($0)") }
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            Spacer()
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .onAppear { self.resource.load() }
        .onDisappear { self.resource.cancel() }
    }
}
