//
// Copyright 2017 niji
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import JSONCodable
import RxSwift

struct SerializationServiceJSONCodable {
 
  // MARK: parse func
  func parse<T: JSONDecodable>(object: Any) -> Observable<T> {
    return Observable.create { observer in
      do {
        if let json = object as? JSONObject {
          let object = try T(object: json)
          observer.on(.next(object))
          observer.on(.completed)
        } else {
          let error = SerializationServiceError.unexpectedFormat(json: object)
          observer.on(.error(error))
        }
      } catch {
        observer.on(.error(error))
      }
      return Disposables.create()
    }
  }
  
  func parse<T: JSONDecodable>(objects: Any) -> Observable<[T]> {
    return Observable.create({ observer in
      var objectList = [T]()
      let objectsToDeserialize: [Any]
      if let objects = objects as? [Any] {
        objectsToDeserialize = objects
      } else {
        objectsToDeserialize = [objects]
      }
      
      for objectItem in objectsToDeserialize {
        if let objectItem = objectItem as? JSONObject {
          do {
            let object = try T.init(object: objectItem)
            objectList.append(object)
          } catch {
            observer.on(.error(error))
          }
        }
      }
      observer.on(.next(objectList))
      observer.on(.completed)
      return Disposables.create()
    })
  }
  
  func parse<T: JSONDecodable>(object: Any) throws -> T {
    guard let jsonObject = object as? JSONObject else {
      throw SerializationServiceError.unexpectedFormat(json: "Failed to parse json : \(object) to \(T.self)")
    }
    return try T(object: jsonObject)
  }
  
  func parse<T: JSONDecodable>(objects: Any) throws -> [T] {
    var objectList = [T]()
    let objectsToDeserialize: [Any]
    if let objects = objects as? [Any] {
      objectsToDeserialize = objects
    } else {
      objectsToDeserialize = [objects]
    }
    
    for objectItem in objectsToDeserialize {
      if let objectItem = objectItem as? JSONObject {
        do {
          let object = try T.init(object: objectItem)
          objectList.append(object)
        } catch {
          throw SerializationServiceError.unexpectedFormat(json: "Failed to parse json : \(objects) to \(T.self)")
        }
      }
    }
    return objectList
  }

}
