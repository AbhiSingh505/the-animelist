//
//  Expandview.swift
//  myanimelist
//
//  Created by Abhishek Singh Chouhan on 16/08/25.
//

import SwiftUI

struct Expandview: View {
    let animeitem:Anime.Data?
    @State var click=false
    var body: some View {
        
        //      Color.gray.ignoresSafeArea()
        ScrollView{
            VStack{
                Text("Synopsis")
                AsyncImage(url:URL(string:animeitem?.images.jpg.imageUrl ?? "nil")){ img in
                    img.resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                }placeholder: {
                    ProgressView()
                }
                
                if let score = animeitem?.score {
                    Text("⭐️ Rating: \(String(format: "%.1f", score))")
                }
                
                Text("Type: \(animeitem?.type ?? "N/A")")
                Text("Episodes: \(animeitem?.episodes ?? 0)")
                Text("Status: \(animeitem?.status ?? "none")")
                if let year = animeitem?.year {
                    Text("Year: \(year)")
                }
                
                Divider()
                
                Text("Synopsis").font(.headline)
                Text(animeitem?.synopsis ?? "No synopsis available.")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .toolbar{
            ToolbarItem{
                Button{
                    click.toggle()
                   
                }label:{
                    Image(systemName: click ? "heart.fill" : "heart")
                }
            }
        }
        .navigationTitle(animeitem?.title ?? "No Title")
              .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    Expandview(animeitem:nil)
}
