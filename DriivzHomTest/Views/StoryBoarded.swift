//
//  StoryBoarded.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 26/05/2023.
//

import UIKit

protocol Storyborded {
    static func instantiate() -> Self
}

extension Storyborded where Self: UIViewController  {
    
    static func instantiate() -> Self {
        let id = String (describing: self)
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storybord.instantiateViewController(withIdentifier: id) as! Self
    }
    
    static func instantiate(from storybordName: String) -> Self {
        let id = String (describing: self)
        let storybord = UIStoryboard(name: storybordName, bundle: Bundle.main)
        return storybord.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
