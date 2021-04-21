//
//  Request.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 13/04/2021.
//

import Foundation
import RxSwift

class Request: ControlledOperation {
  /**
   Methode de la requête
   - .delete
   - .download
   - .get
   - .post
   - .put
   */
  enum Method: String {
    case delete
    case download
    case get
    case post
    case put
    case upload
  }

  /**
   RxSwift. Renvoie le résultat/Erreur de la requête
   */
  var observable: Observable<Any>!

  /**
   RxSwift. Utilisé afin d'activer l'observable
   */
  var observer: AnyObserver<Any>?

  /**
   Corps de la requête
   */
  var body: [String: Any]?

  /**
   En-tête de la requête
   */
  var headers: [String: String]?

  /**
   Paramètres de la requête
   */
  var parameters: [String: String]?

  /**
   Méthode de la requête
   */
  var method: Method!

  /**
   Type accepté
   */
  var accept: String = "json"

  /**
   Adresse de la méthode
   */
  var address: String!

  /**
   Nom du fichier à télécharger
   */
  var fileName: String = ""

  /**
   Nom de la notification dexpiration de session
   */
  static var sessionTimeoutNotification = Notification.Name("sessionTimeout")

  init(address: String,
       parameters: [String: String]?,
       body: [String: Any]? = nil,
       headers: [String: String]? = nil,
       method: Method,
       accept: String = "json",
       fileName: String = "") {
    super.init()
    self.address = address
    self.parameters = parameters
    self.body = body
    self.headers = headers
    self.method = method
    self.accept = accept
    self.fileName = fileName

    self.observable = Observable.create({ [weak self] (observer) -> Disposable in
      self?.observer = observer
      return Disposables.create {}
    })
  }

  override func main() {
    super.main()
    request()
  }

  /**
   Crée le vrai objet utilisé pour la requête avec toutes les informations données
   - Returns: URLRequest
   */
  func createRequest() -> URLRequest {
    Communicator.shared.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData

    var urlComponents = URLComponents(string: address)!
    if let parameters = parameters {
      urlComponents.queryItems = []
      for (key, value) in parameters {
        urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
      }
      urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

    }

    var request = URLRequest(url: urlComponents.url!)
    if let body = body {
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
      } catch let error {
        print("Error : \(error)")
      }
    }

    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/" + accept, forHTTPHeaderField: "Accept")
    if method != Method.download {
      request.httpMethod = method.rawValue.uppercased()
    } else {
      request.httpMethod = "GET"
    }
    if let headers = headers {
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }

    return request
  }

  func request() {
    if method != Method.download {
      simpleRequest()
    } else {

    }
  }

  private func simpleRequest() {
    let request = createRequest()
    Communicator.shared.session.dataTask(with: request) { (data, response, error) in
      if self.hasError(data: data, response: response, error: error) {
        self.state = .finished
        return
      }
      if let data = data {
        self.observer?.onNext(data)
        self.state = .finished
      } else {
        self.observer?.onError(ErrorCommunicator.error(data, response, error))
        self.state = .finished
      }
    }.resume()
  }

  private func download() {
    let request = createRequest()
    Communicator.shared.session.downloadTask(with: request) { (url, response, error) in
      if self.hasError(response: response, error: error, url: url) {
        self.state = .finished
        return
      }

      if let url = url {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                       FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath: String = path[0]
        var fileUrl = self.fileName.components(separatedBy: "/")
        self.fileName = (fileUrl.popLast() ?? "")
        let filePath = fileUrl.joined(separator: "/")

        if !FileManager.default.fileExists(atPath: documentDirectoryPath + filePath) {
          try? FileManager.default.createDirectory(atPath: documentDirectoryPath + filePath,
                                                   withIntermediateDirectories: true, attributes: nil)
        }
        let endPath = "/" + self.fileName
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + filePath + endPath)
        try? FileManager.default.removeItem(at: destinationURLForFile)
        try? FileManager.default.copyItem(at: url, to: destinationURLForFile)
        self.observer?.onNext(destinationURLForFile.absoluteString)
        self.state = .finished
      } else {
        self.observer?.onError(ErrorCommunicator.error(nil, response, error))
        self.state = .finished
      }
    }.resume()
  }

  private func upload (name: String) {
    guard let file = URL(string: name) else {return}
    let request = createRequest()
    Communicator.shared.session.uploadTask(with: request, fromFile: file) { data, urlResponse, error in
      if self.hasError(data: data, response: urlResponse, error: error) {
        self.state = .finished
        return
      }
      if let data = data {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        self.observer?.onNext(json ?? [])
        self.state = .finished
      } else {
        self.observer?.onError(ErrorCommunicator.error(data, urlResponse, error))
        self.state = .finished
      }
    }.resume()
  }

  /**
   Vérifie la réponse de la requete, appelle le refreshToken si besoin
   - Parameters:
   - data: Data de la requête
   - response: Réponse de la requête
   - error: Erreur de la requête
   - url: Url de la requête
   - Returns: Retroune vrai si on a une erreur
   */
  func hasError(data: Data? = nil, response: URLResponse?, error: Error?, url: URL? = nil) -> Bool {
    if let response = response as? HTTPURLResponse {
      if response.statusCode < 200 || response.statusCode >= 300 {
        if response.statusCode == 401 {
          // Logout: The connection with the EV Charger reaches the session timeout
          // Send a notification which will be intercepted in the "EVSEViewController" controller
          notifySessionTimeout()
        }
        self.observer?.onError(ErrorCommunicator.error(data, response, error))
        return true
      }
    }

    if let error = error {
      self.observer?.onError(ErrorCommunicator.error(data, response, error))
      self.state = .finished
      return true
    }

    return false
  }

  /// Notify the controller "EVSEViewController" for displaying the disconnection Popup
  func notifySessionTimeout() {
    NotificationCenter.default.post(name: Request.sessionTimeoutNotification, object: nil)
  }

}
