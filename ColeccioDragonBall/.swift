//
//  UltimateComicsView.swift
//  ColeccioDragonBall
//
//  Created by Jordi on 1/7/25.
//


import SwiftUI

struct UltimateComicsView: View {
    @State private var ultimateComics: [Comic] = (1...34).map {
        Comic(id: $0, title: "Volum \($0)", imageName: "ultimate\($0)", owned: false)
    }

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach($ultimateComics) { $comic in
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 6) {
                            Image(comic.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .grayscale(comic.owned ? 0 : 1)
                                .opacity(comic.owned ? 1.0 : 0.4)
                                .scaleEffect(comic.owned ? 1.1 : 1.0)
                                .animation(.easeInOut(duration: 0.25), value: comic.owned)
                                .frame(height: 100)
                                .onTapGesture {
                                    comic.owned.toggle()
                                }
                                .onLongPressGesture {
                                    comic.isFavorite.toggle()
                                }

                            Text(comic.title)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }

                        if comic.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.green)
                                .padding(4)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                                .offset(x: -6, y: 6)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("Ultimate")
    }
}
