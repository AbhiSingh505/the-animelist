//
//  ContentView.swift
//  myanimelist
//
//  Created by Abhishek Singh Chouhan on 16/08/25.
//

import SwiftUI

struct ContentView: View {
    @State var anime:Anime?
    @State var search="naruto"
    var body: some View {
        NavigationStack{
            
            ScrollView{
                ForEach(anime?.data ?? [],id:\.malId){ i in
                    
                    NavigationLink{
                        Expandview(animeitem:i)
                    } label:{
                        
                        HStack(spacing:12){
                            
                            AsyncImage(url:(URL(string:i.images.jpg.imageUrl ))){ img in
                                img.resizable()
                                    .scaledToFit()
                                    .frame(width:60,height:60)
                                    .cornerRadius(8)
                            }placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment:.leading,spacing:6){
                                Text(i.title).bold()
                                HStack(spacing:4){
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                    if let score = i.score {
                                        Text("\(String(format: "%.1f", score))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                        .padding(.vertical,4)
                    }
                }
                
                
            }
            
            
            
            .task{
                do{
                    let ans=try await fetchdata(query:search)
                    anime=ans
                    
                    print(ans)
                }catch{
                    print("error loading the data: ",error)
                }
            }
            .searchable(text: $search, prompt: "search anime")
            .onChange(of: search) { newValue in
                Task {
                    do {
                        anime = try await fetchdata(query:newValue)
                    } catch {
                        print("Search error:", error)
                    }
                }
            }
            .toolbar{
                Button{
                    
                }label:{
                    Text("Favourites")
                }
            }
            .navigationTitle("My AnimeList")
        }
        
    }
    func fetchdata(query:String) async throws->Anime{
        let rawString = "https://api.jikan.moe/v4/anime?q=\(query)"
        guard let
                
                url=URL(string:rawString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")else{
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from:url)
        return try JSONDecoder().decode(Anime.self,from:data)
    }
    
}

#Preview {
    ContentView()
}


