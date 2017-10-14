//
//  AppAssembly.swift
//  TMDb
//
//  Created by Carlos on 13/10/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

//import Foundation
import UIKit
import TMDbCore

final class AppAssembly {
    private(set) lazy var window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var navigationController = UINavigationController()
    private(set) lazy var coreAssembly = CoreAssembly() // Más adelante inyectaremos el navigatorController porque se comparte
}
