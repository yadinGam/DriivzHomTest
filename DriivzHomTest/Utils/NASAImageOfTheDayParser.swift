//
//  NASAImageOfTheDayParser.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 27/05/2023.
//

import Foundation

class NASAImageOfTheDayParser: NSObject {
    
    private var elementName = String()
    private var items: [Article] = []
    private var itemTitle = String()
    private var itemDescription = String()
    private var link = String()
    private var pubDate = String()
    
    private struct Constants {
        static let nasaRssLink = "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"
        static let itemKey = "item"
        static let urlKey = "url"
        static let titleKey = "title"
        static let descriptionKey = "description"
        static let enclosureKey = "enclosure"
        static let pubDateKey = "pubDate"
    }
    
    class func shared() -> NASAImageOfTheDayParser {
        return self.informationParser
    }
    
    private static var informationParser: NASAImageOfTheDayParser = {
        let parser = NASAImageOfTheDayParser()
        return parser
    }()
    
    func parseRSSFeed(completion: @escaping NewsCompletion) {
        guard let url = URL(string: Constants.nasaRssLink) else {
            completion(.failure(.UrlComponentError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            
            guard let self = self else {
                completion(.failure(.ClassError))
                return
            }
            
            if let error = error {
                completion(.failure(.NetworkError(error)))
                return
            }
            
            if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
                
                completion(.success(self.items))
            }
        }.resume()
    }
    
    private func resetValues() {
        self.pubDate = String()
        self.itemTitle = String()
        self.itemDescription = String()
        self.link = String()
    }
}

extension NASAImageOfTheDayParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
       
        if elementName == Constants.itemKey {
            self.resetValues()
        } else if elementName == Constants.enclosureKey {
            if let url = attributeDict[Constants.urlKey] {
                self.link = url
            }
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == Constants.itemKey {
            let item = Article(title: self.itemTitle, description: self.itemDescription, link: self.link, date: self.pubDate)
            self.items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            switch elementName {
            case Constants.titleKey:
                self.itemTitle += data
            case Constants.descriptionKey:
                if(itemDescription.isEmpty) {
                    self.itemDescription += data
                }
            case Constants.enclosureKey:
                self.link += data
            case Constants.pubDateKey:
                self.pubDate += data
            default:
                break
            }
        }
    }
}

