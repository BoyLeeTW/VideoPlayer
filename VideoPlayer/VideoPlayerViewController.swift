//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Brad on 06/09/2017.
//  Copyright © 2017 Brad. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {

    let videoSearchBar = UISearchBar()

    let playVideoButton = UIButton()

    let muteVideoButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVideoSearchingTextField()

        setUpGestureRecognize()

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

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)

    }

    func dismissKeyboard() {

        view.endEditing(true)
    }

}

extension VideoPlayerViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        guard let searchBarResultString = videoSearchBar.text,
              let searchBarResultURL = URL(string: searchBarResultString)
              else { return }

        let playerViewController = AVPlayerViewController()

        let player = AVPlayer(url: searchBarResultURL)

        playerViewController.player = player

        self.present(playerViewController, animated: true, completion: {

            playerViewController.player?.play()

        })

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()

    }
}
