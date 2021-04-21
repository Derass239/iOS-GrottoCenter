//
//  GrottoCenterConstants.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 11/02/2021.
//

import Foundation

class GrottoCenterConstants {
  static var adresse: String {
    return "https://beta.grottocenter.org/api/v1"
  }

  // MARK: - AUTHENTIFICATION
  static var login: String { adresse + "/login" }
  static var signup: String { adresse + "/signup" }
  
  // MARK: - DOCUMENTS
  static var documents: String { adresse + "/documents" }
  
  // MARK: - ENTRANCES
  static var entrances: String { adresse + "/entrances" }
  
  // MARK: - GEOLOC
  static var geoloc: String { adresse + "/geoloc" }
  
  // MARK: - MASSIFS
  static var massifs: String { adresse + "/massifs" }
  
  // MARK: - ORGANIZATIONS
  static var organizations: String { adresse + "/organizations" }
  
  // MARK: - SEARCH
  static var search: String { adresse + "/search" }
  static var advancedSearch: String { adresse + "advanced-search" }
  
  // MARK: - SUBJECTS
  static var subjects: String { documents + "/subjects" }
  
  // MARK: - CAVES
  static var caves: String { adresse + "/caves" }
}
