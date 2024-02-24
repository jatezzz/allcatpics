//
//  String+Extension.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

extension String {
    func generateName() -> String {
        let vowels = "aeiouAEIOU"
        let consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
        
        var result = ""
        var syllableCount = 0
        
        var consonantQueue: [Character] = []
        var vowelQueue: [Character] = []
        
        for char in self {
            if consonants.contains(char) {
                consonantQueue.append(char)
            } else if vowels.contains(char) {
                vowelQueue.append(char)
            }
            
            if !consonantQueue.isEmpty && !vowelQueue.isEmpty {
                result.append(consonantQueue.removeFirst())
                result.append(vowelQueue.removeFirst())
                syllableCount += 1
            }
            
            if syllableCount == 3 {
                break
            }
        }
        
        // If less than 3 syllables and any consonants are left, add them
        while syllableCount < 3 && !consonantQueue.isEmpty {
            result.append(consonantQueue.removeFirst())
            syllableCount += 1
        }
        
        return result
    }

}
