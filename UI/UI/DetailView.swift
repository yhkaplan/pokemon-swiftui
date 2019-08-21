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

    init(pokemon: Pokemon) {
        let endpoint = pokemonEndpoint(pokemon: pokemon)
        self.resource = Resource<Pokemon>(endpoint: endpoint)
    }

    var body: some View {
        VStack {
            HStack {
                resource.result?.value?.sprites?.frontDefault.map { URLImage($0) }
                Text(resource.result?.value?.name.capitalized ?? "-")
                    .font(.largeTitle)
            }
            Spacer()
        }.onDisappear { self.resource.cancel() }
    }
}
