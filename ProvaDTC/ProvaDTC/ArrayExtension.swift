//
//  ArrayExtension.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

extension Array where Element: Hashable {
    
    func unique() -> [(Element, Int)] {
        
        /*
         Returns an array containing tuples of unique elements from the original array along with their counts.

         - Returns: An array of tuples where each tuple contains a unique element from the original array and its count.

         - Note: This method preserves the order of elements in the original array.

         */
        
        var uniqueElementsArr = [(Element, Int)]()
        
        for element in self {
            
            if let index = uniqueElementsArr.firstIndex(where: { $0.0 == element }) {
                
                uniqueElementsArr[index].1 += 1
                
            } else {
                
                uniqueElementsArr.append((element, 1))
            }
        }
        
        return uniqueElementsArr
    }
    
}
