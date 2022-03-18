//
//  ComicRowView.swift
//  xkcd
//
//  Created by Peter Ahlgren on 2022-03-17.
//

import SwiftUI

struct ComicRowView: View {
    
    var comic: Comic
    
    var body: some View {
        
        VStack (spacing: 15) {
            
            AsyncImage(url: URL(string: comic.img))
                //.resizable()
                //.aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 100)
                .scaledToFit()
                .clipShape(Rectangle())
        

            Text(comic.title)
                .fontWeight(.bold)
            
            Text(comic.alt)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                (
                    Text("No: ")
                        .bold()
                        .font(.caption)
                    +
                    Text(String(comic.num))
                        .font(.caption)
                )
                
                Spacer()
                
                (
                    Text("Year: ")
                        .bold()
                        .font(.caption)
                    +
                    Text(comic.year)
                        .font(.caption)
                )
                
                (
                    Text("Month: ")
                        .bold()
                        .font(.caption)
                    +
                    Text(comic.month)
                        .font(.caption)
                )
                
                
            } //: HSTACK
                
            
        } //: VSTACK
        .padding()
        
    }
}

struct ComicRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
