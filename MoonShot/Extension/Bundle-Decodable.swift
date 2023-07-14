//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Oguzhan Ozturk on 12.07.2023.
//

import Foundation

extension Bundle {
    
    func getData<T: Codable>(fileName: String) -> T {
        
        guard let fileUrl = self.url(forResource: fileName, withExtension: nil) else {
            fatalError("File Url Not Found")
        }
        
        guard let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Read Error")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let objects =  try? decoder.decode(T.self, from: data) else {
            fatalError("Parsing Error")
        }
        
        return objects
        
    }
    
}
