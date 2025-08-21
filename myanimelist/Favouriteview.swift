//
//  Favouriteview.swift
//  myanimelist
//
//  Created by Abhishek Singh Chouhan on 16/08/25.
//

import SwiftUI

struct Favouriteview: View {
    var arr:[String]=[]
    @State var change=false
    @State var name:Anime?
    
    var body: some View {
   //
        List(name?.data ?? [],id:\.malId){ i in
            Text(i.title)
        }
    }
}

#Preview {
    Favouriteview()
   // Expandview(animeitem: nil)
}
