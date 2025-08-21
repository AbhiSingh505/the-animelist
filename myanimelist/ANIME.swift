//
//  ANIME.swift
//  myanimelist
//
//  Created by Abhishek Singh Chouhan on 16/08/25.
//

import Foundation
struct Anime:Codable{
    let data:[Data]
    struct Data:Codable{
        let malId:Int
        let title: String
            let titleEnglish: String?
            let type: String?
            let episodes: Int?
            let status: String
            let year: Int?
            let score: Double?
            let synopsis: String?
            let images:Images
        enum CodingKeys:String,CodingKey{
            case titleEnglish="title_english"
            case malId="mal_id"
         
            case title,type,episodes,status,year,score,synopsis,images
        }
        struct Images:Codable{
            let jpg:Jpg
        }
        struct Jpg:Codable {
            let imageUrl:String
            enum CodingKeys:String,CodingKey{
                case imageUrl="image_url"
            }
        }
    }
  
}

