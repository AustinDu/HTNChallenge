//
//  NetworkManager.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    
    enum Router: URLRequestConvertible {
        case getParticipants()

        static let baseURLString = "https://htn-interviews.firebaseio.com/"
        
        var method: HTTPMethod {
            switch self {
            case .getParticipants:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getParticipants:
                return "users.json"
            }
        }
        
        // MARK: URLRequestConvertible
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURLString.asURL()
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            switch self {
                // for parameter encoding if needed (not needed in this app)
            default:
                break
            }
            
            return urlRequest
        }
    }
    
    func getParticipants(completion: @escaping (_ result: [Participant])->Void) {
        var participants: [Participant] = []
        Alamofire.request(Router.getParticipants())
        .responseJSON { (response) in
            switch response.result {
            case .success(let result):
                if let people = result as? [Any] {
                    for person in people {
                        if let person = person as? NSDictionary {
                            let personJSON = JSON(person)
                            let newParticipant = Participant()
                            
                            newParticipant.company = personJSON["company"].stringValue
                            newParticipant.email = personJSON["email"].stringValue
                            newParticipant.latitude = personJSON["latitude"].stringValue
                            newParticipant.longitude = personJSON["longitude"].stringValue
                            newParticipant.name = personJSON["name"].stringValue
                            newParticipant.phone = personJSON["phone"].stringValue
                            newParticipant.picture = personJSON["picture"].stringValue
                            
                            let skills = personJSON["skills"]
                            for skill in skills {
                                let newSkill: (String?, Int?) = (skill.1["name"].stringValue, skill.1["rating"].intValue)
                                newParticipant.skills.append(newSkill)
                            }
                            
                            participants.append(newParticipant)
                        }
                    }
                }
                completion(participants)
            case .failure(let error):
                print(error)
                completion(participants)
            }
        }
    }
    
}
