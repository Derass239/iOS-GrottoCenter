//
//  JSON.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 14/04/2021.
//

import Foundation

/// Classe permettant de simplifier l'utilisation d'objet json
public class JSON {
  /// Reel objet
  public var object: Any?

  /// Initialise un json vide
  /// Peut etre compléter avec les subscripts
  public init() {}

  /// Initialise un json à partir d'un fichier se trouvant dans le projet
  /// - Parameters:
  ///   - ressource: Nom du fichier .json
  public convenience init(ressource: String) {
    let path = Bundle.main.path(forResource: ressource, ofType: "json")!
    self.init(FileManager.default.contents(atPath: path))
  }

  /// Initialise un json avec un objet quelconque pouvant etre nulle
  /// - Parameters:
  ///   - object: Objet de n'importe quel type
  public init(_ object: Any?) {
    self.object = object
    if let data = object as? Data {
      self.object = try? JSONSerialization.jsonObject(with: data,
                                                      options: JSONSerialization.ReadingOptions.mutableContainers)
    }
  }

  // --------------------------------------------------------------------
  // ---------------------------- SUBSCRIPT -----------------------------
  // --------------------------------------------------------------------

  /// Subscript pour un tableau
  /// Peut uniquement faire le set afin d'éditer l'objet JSON
  /// - Parameters:
  ///   - index: Index du tableau
  public subscript(index index: Int) -> Any {
    // On n'autorise pas le get
    get { fatalError("") }
    set {
      // Si le json est initialisé avec du vide, alors on crée le tableau
      if object == nil {
        object = [Any]()
      }

      // On complete le tableau avec la nouvelle donnée
      guard var newJson = object as? [Any] else { return }
      newJson.insert(newValue, at: index)
      object = newJson
    }
  }

  /// Subscript pour un tableau
  /// - Parameters:
  ///   - index: Index du tableau
  public subscript(index: Int) -> JSON {
    // On retourne un nouveau json correspondant à un champs du tableau
    get {
      return JSON((object as? [Any])?[index])
    }
    set {
      // Si le json est initialisé avec du vide, alors on crée le tableau
      if object == nil {
        object = [Any]()
      }

      // On complete le tableau avec le 2eme json
      guard var newJson = object as? [Any] else { return }
      if let value = newValue.object {
        newJson.insert(value, at: index)
      }
      object = newJson
    }
  }

  /// Subscript pour un dictionary
  /// Peut uniquement faire le set afin d'éditer l'objet JSON
  /// - Parameters:
  ///   - key: Clé du dictionary
  public subscript(key key: String) -> Any {
    // On n'autorise pas le get
    get { fatalError("") }
    set {
      // Si le json est initialisé avec du vide, alors on crée le dictionary
      if object == nil {
        object = [String: Any]()
      }

      // On complete le dictionary avec la nouvelle donnée
      guard var newJson = object as? [String: Any] else { return }
      newJson[key] = newValue
      object = newJson
    }
  }

  /// Subscript pour un dictionary
  /// - Parameters:
  ///   - key: Clé du dictionary
  public subscript(key: String) -> JSON {
    // On retourne un nouveau json correspondant à un champs du dictionary
    get {
      return JSON((object as? [String: Any])?[key])
    }
    set {
      // Si le json est initialisé avec du vide, alors on crée le dictionary
      if object == nil {
        object = [String: Any]()
      }

      // On complete le dictionary avec le 2eme json
      guard var newJson = object as? [String: Any] else { return }
      newJson[key] = newValue.object
      object = newJson
    }
  }

  // --------------------------------------------------------------------
  // ---------------------------- CONVERSION ----------------------------
  // --------------------------------------------------------------------
  public var arrayJSON: [JSON]? {
    return array?.map { return JSON($0) }
  }
  public var dictionaryJSON: [String: JSON]? {
    guard let dictionary = dictionary else { return nil }
    var newDictionary = [String: JSON]()
    for (key, value) in dictionary {
      newDictionary[key] = JSON(value)
    }
    return newDictionary
  }
  public var array: [Any]? { return object as? [Any] }
  public var bool: Bool? { return object as? Bool }
  public var dictionary: [String: Any]? { return object as? [String: Any] }
  public var double: Double? { return object as? Double }
  public var int: Int? { return object as? Int }
  public var string: String? { return object as? String }
  public var stringArray: [String]? { return object as? [String] }

  /// Récupère la valeur d'un champs json
  /// Si le cast fail, retourne la valeur par defaut
  /// - Parameters:
  ///   - defaultValue: valeur renvoyé si le cast fail
  public func value<T>(_ defaultValue: T) -> T {
    return object as? T ?? defaultValue
  }

  /// Récupère la valeur d'un champs json
  /// Si le cast fail, retourne nil
  public func value<T>() -> T? {
    return object as? T
  }
}
