//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Brad on 06/09/2017.
//  Copyright © 2017 Brad. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    let videoSearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVideoSearchingTextField()

    }

    func setUpVideoSearchingTextField() {

        self.view.addSubview(videoSearchBar)

        videoSearchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 27).isActive = true

        videoSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        videoSearchBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 30.0 / 667.0).isActive = true

        videoSearchBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 359.0 / 370.0 ).isActive = true

        videoSearchBar.translatesAutoresizingMaskIntoConstraints = false

        videoSearchBar.barTintColor = .clear

        videoSearchBar.layer.cornerRadius = 5

        videoSearchBar.placeholder = "Enter URL of video"

        videoSearchBar.delegate = self

    }

    func setUpGestureRecognize() {

//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.disablesAutomaticKeyboardDismissal))

//        view.addGestureRecognizer(tap)

    }

}

extension VideoPlayerViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        print("DONE!!!!!")

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()

    }
}
