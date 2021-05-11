//
//  RemoteConfig.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 29/04/2021.
//

import Foundation
import RxSwift
import Firebase

class RemoteConfigService {

  var remoteConfig : RemoteConfig!

  init() {

    remoteConfig = RemoteConfig.remoteConfig()

    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    remoteConfig.configSettings = settings

    remoteConfig.setDefaults(["":""] as [String: NSObject])

  }
}
