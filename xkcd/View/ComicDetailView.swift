//
//  ComicDetailView.swift
//  xkcd
//
//  Created by Peter Ahlgren on 2022-03-17.
//

import SwiftUI

struct ComicDetailView: View {
    
    var comic: Comic
    
    var body: some View {
        
        let explainLink: String = "https://www.explainxkcd.com/wiki/index.php/" + String(comic.num) + ":_" + comic.safe_title.replacingOccurrences(of: " ", with: "_")
        
        ScrollView {
            VStack  {
                
                AsyncImage(url: URL(string: comic.img)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                
                Text(comic.title)
                    .font(.title)
                    .padding(.bottom)
                
                Text(comic.alt)
                    .font(.caption)
                    .padding(.bottom)
                
                HStack {
                    
                    Spacer()
                    
                    Link(destination: URL(string: explainLink)!) {
                        VStack {
                            Image(systemName: "questionmark.square.fill")
                                .font(.largeTitle)
                            
                            Text("Explaination")
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        print("Favorite")
                    } label: {
                        VStack {
                            Image(systemName: "star.square.fill")
                                .font(.largeTitle)
                            
                            Text("Favorite")
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        actionSheet()
                    } label: {
                        VStack {
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.largeTitle)
                            
                            Text("Share")
                                .font(.caption)
                        }
                        .padding(.top, -10)
                    }
                    
                    Spacer()
                    
                } //: HSTACK
                    
                
            } //: VSTACK
        } //: SCROLLVIEW
        .padding()
    }
    
    func actionSheet() {
        guard let data = URL(string: "https://xkcd.com/" + String(comic.num)) else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

//struct ComicDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicDetailView(comic: <#T##Comic#>)
//    }
//}
