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

        // Split characters into consonants and vowels
        for char in self {
            if consonants.contains(char) {
                consonantQueue.append(char)
            } else if vowels.contains(char) {
                vowelQueue.append(char)
            }
        }

        // Try forming up to 3 syllables
        while syllableCount < 3 && (!consonantQueue.isEmpty || !vowelQueue.isEmpty) {
            var syllable = ""

            // Add consonant if available
            if !consonantQueue.isEmpty {
                syllable += String(consonantQueue.removeFirst())
            }

            // Add vowel if available
            if !vowelQueue.isEmpty {
                syllable += String(vowelQueue.removeFirst())
                syllableCount += 1 // A valid syllable is only counted when a vowel is added
            } else if !syllable.isEmpty {
                // If we have a consonant but no vowel, still count it as a syllable for the purpose of this task
                syllableCount += 1
            }

            result += syllable
        }

        return result.capitalized
    }

    func formatDateString(fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: String = "MMM d, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }

}
