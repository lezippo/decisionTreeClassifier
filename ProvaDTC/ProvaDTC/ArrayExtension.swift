//
//  ArrayExtension.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

extension Array where Element: Hashable {
    
    func unique() -> [(Element, Int)] {
        
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


