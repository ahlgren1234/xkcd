//
//  ComicsViewModel.swift
//  xkcd
//
//  Created by Peter Ahlgren on 2022-03-17.
//

import Foundation
import SwiftUI

struct Comic: Hashable, Codable {
  
    let month: String
    let num: Int
    let link: String
    let year: String
    let news: String
    let safe_title: String
    let transcript: String
    let alt: String
    let img: String
    let title: String
    let day: String
}




class ComicsViewModel: ObservableObject {
    

    
    @Published var comics: [Comic] = []
    
    @Published var currentComicStartIndex: Int = 0
    @Published var comicIndex: Int = 20
    @Published var comicLatestIndex: Int = 0
    
    
    func getLatestComic() {
        let urlString = "https://xkcd.com/info.0.json"
        
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(Comic.self, from: data)
                    
                    if decodedData.num > self.comicLatestIndex {
                        self.comicLatestIndex = decodedData.num
                    }
                    self.currentComicStartIndex = self.comicLatestIndex
                    self.comicIndex = self.currentComicStartIndex - 20
                    
                    self.fetch()
                    
                } catch {
                    print("decode error")
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func fetch() {

        for i in (comicIndex...currentComicStartIndex).reversed() {
            let urlString = "https://xkcd.com/\(i)/info.0.json"
            
            self.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    self.parse(jsonData: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    }
    
    
    
    private func loadJson(fromURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Comic.self, from: jsonData)
            //print(decodedData)
            
            if decodedData.num > comicLatestIndex {
                comicLatestIndex = decodedData.num
            }
            print(comicLatestIndex)
            
            comics.append(Comic(month: decodedData.month, num: decodedData.num, link: decodedData.link, year: decodedData.year, news: decodedData.news, safe_title: decodedData.safe_title, transcript: decodedData.transcript, alt: decodedData.alt, img: decodedData.img, title: decodedData.title, day: decodedData.day))
        } catch {
            print("decode error")
        }
    }
}



