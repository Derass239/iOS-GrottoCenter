//
//  Communicator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 13/04/2021.
//

import Foundation
import RxSwift
import Security

enum ErrorCommunicator: Error {
  case error(Data?, URLResponse?, Error?)
  case simpleError(String)
}

class Communicator {
  /// OperationQueue sera complétée avec des Operations de type Request
  /// permettant ainsi de lancer une requête l’une après l’autre.
  var operationQueue = OperationQueue()

  /**
   Singleton
   */
  static var shared = Communicator()

  var session: URLSession = URLSession.shared

  private init() {
    clear()
  }

  /**
   Crée l'objet Request comporant toutes les informations données en paramètre
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - method: Method (GET, POST, PUT, DELETE)
   - accept: Type accepté
   - fileName: Nom pour un fichier en cas de download
   - Returns: L'object Request
   */
  func createRequest(address: String,
                     parameters: [String: String]? = nil,
                     body: [String: Any]? = nil,
                     headers: [String: String]? = nil,
                     method: Request.Method,
                     accept: String = "json",
                     fileName: String = "") -> Request {
    return Request(address: address,
                       parameters: parameters,
                       body: body,
                       headers: headers,
                       method: method,
                       accept: accept,
                       fileName: fileName)
  }

  /**
   Ajoute une request à la file de requête
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - method: Method (GET, POST, PUT, DELETE)
   - success: Completion retournant le json récupéré
   - failure: Completion retournant l'erreur
   - accept: Type accepté
   - fileName: Nom pour un fichier en cas de download
   - Returns: Observable qui retournera soit le json, soit une erreur
   */
  func appendToQueue(address: String,
                     parameters: [String: String]? = nil,
                     body: [String: Any]? = nil,
                     headers: [String: String]? = nil,
                     method: Request.Method,
                     observer: AnyObserver<Any>? = nil,
                     accept: String = "json",
                     fileName: String = "") -> Observable<Any> {
    let request = createRequest(address: address,
                                parameters: parameters,
                                body: body,
                                headers: headers,
                                method: method,
                                accept: accept,
                                fileName: fileName)
    appendToQueue(request: request)
    return request.observable
  }

  /**
   Ajoute une request à la file de requête
   - Parameters:
   - request: Requête
   */
  func appendToQueue(request: Request) {
    operationQueue.addOperation(request)
  }

  /**
   Crée une requête POST
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - Returns: Observable qui retournera soit le json, soit une erreur
   */
  func post(address: String,
            parameters: [String: String]? = nil,
            body: [String: Any]? = nil,
            headers: [String: String]? = nil) -> Observable<Any> {
    return appendToQueue(address: address,
                         parameters: parameters,
                         body: body,
                         headers: headers,
                         method: .post)
  }

  /**
   Crée une requête GET
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - Returns: Observable qui retournera soit le json, soit une erreur
   */
  func get(address: String,
           parameters: [String: String]? = nil,
           body: [String: Any]? = nil,
           headers: [String: String]? = nil) -> Observable<Any> {
    return appendToQueue(address: address,
                         parameters: parameters,
                         body: body,
                         headers: headers,
                         method: .get)
  }

  /**
   Crée une requête PUT
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - Returns: Observable qui retournera soit le json, soit une erreur
   */
  func put(address: String,
           parameters: [String: String]? = nil,
           body: [String: Any]? = nil,
           headers: [String: String]? = nil) -> Observable<Any> {
    return appendToQueue(address: address,
                         parameters: parameters,
                         body: body,
                         headers: headers,
                         method: .put)
  }

  /**
   Crée une requête DELETE
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - Returns: Observable qui retournera soit le json, soit une erreur
   */
  func delete(address: String,
              parameters: [String: String]? = nil,
              body: [String: Any]? = nil,
              headers: [String: String]? = nil) -> Observable<Any> {
    return appendToQueue(address: address,
                         parameters: parameters,
                         body: body,
                         headers: headers,
                         method: .delete)
  }

  func upload(address: String,
              parameters: [String: String]? = nil,
              body: [String: Any]? = nil,
              headers: [String: String]? = nil,
              url: URL) -> Observable<Any> {
    return appendToQueue(address: address,
                         parameters: parameters,
                         body: body,
                         headers: headers,
                         method: .upload)
  }

  /**
   Crée une requête DOWNLOAD
   - Parameters:
   - address: Adresse de la requête
   - parameters: Paramètre de la requête
   - body: Corps de la requête
   - headers: En-tête de la requête
   - Returns: Observable qui retournera soit le json, soit une erreur
   */
  func download(address: String,
                parameters: [String: String]? = nil,
                body: [String: Any]? = nil,
                headers: [String: String]? = nil,
                accept: String,
                fileName: String = "") -> Observable<Any> {
    return appendToQueue(address: address,
                         parameters: parameters,
                         body: body,
                         headers: headers,
                         method: .download,
                         accept: accept,
                         fileName: fileName)
  }

  func clear() {
    operationQueue.cancelAllOperations()
    operationQueue = OperationQueue()
    operationQueue.name = "Communicator Queue"
    operationQueue.maxConcurrentOperationCount = 5
  }

}
