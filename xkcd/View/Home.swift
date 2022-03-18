//
//  Home.swift
//  xkcd
//
//  Created by Peter Ahlgren on 2022-03-17.
//

import SwiftUI



///////////////////////

struct URLImage: View {
    
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(.gray)
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}



//////////////////////////

struct Home: View {
    
    @StateObject var comicsViewModel = ComicsViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List(comicsViewModel.comics, id: \.self) { comic in
                    NavigationLink {
                        ComicDetailView(comic: comic)
                    } label: {
                        ComicRowView(comic: comic)
                    }
                    
                } //: LIST
                .navigationTitle("XKCD")
                .onAppear {
                    comicsViewModel.getLatestComic()
//                    comicsViewModel.currentComicStartIndex = comicsViewModel.comicLatestIndex
//                    comicsViewModel.comicIndex = comicsViewModel.currentComicStartIndex - 20
                    //comicsViewModel.fetch()
                }
                
                Button {
                    comicsViewModel.currentComicStartIndex = comicsViewModel.comicIndex - 1
                    comicsViewModel.comicIndex -= 20
                    comicsViewModel.fetch()
                } label: {
                    Text("Load More...")
                }
            }
            
            
           
        } //: NAVIGATIONVIEW
    
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
