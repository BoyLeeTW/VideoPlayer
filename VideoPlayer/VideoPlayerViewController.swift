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

class VideoPlayerViewController: AVPlayerViewController {

    enum PlayStatus: String {

        case play = "Play"

        case pause = "Pause"

    }

    let videoSearchBar = UISearchBar()

    let playVideoButton = UIButton()

    let muteVideoButton = UIButton()

    let bottomToolBarView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVideoSearchingTextField()

        setUpGestureRecognize()

        setUpBottomToolBar()

        setUpPlayVideoButton()

        setUpMuteVideoButton()

    }

    func setUpVideoSearchingTextField() {

        self.view.addSubview(videoSearchBar)

        videoSearchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 27).isActive = true

        videoSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        videoSearchBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 30.0 / 667.0).isActive = true

        videoSearchBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 359.0 / 375.0 ).isActive = true

        videoSearchBar.translatesAutoresizingMaskIntoConstraints = false

        videoSearchBar.barTintColor = .clear

        videoSearchBar.layer.cornerRadius = 5

        videoSearchBar.placeholder = "Enter URL of video"

        videoSearchBar.delegate = self

    }

    func setUpBottomToolBar() {

        self.showsPlaybackControls = false

        self.view.addSubview(bottomToolBarView)

        bottomToolBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        bottomToolBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        bottomToolBarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 44.0 / 667.0).isActive = true

        bottomToolBarView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        bottomToolBarView.translatesAutoresizingMaskIntoConstraints = false

        bottomToolBarView.backgroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.9)

    }

    func setUpPlayVideoButton() {

        bottomToolBarView.addSubview(playVideoButton)

        playVideoButton.leadingAnchor.constraint(equalTo: bottomToolBarView.leadingAnchor, constant: 20).isActive = true

        playVideoButton.centerYAnchor.constraint(equalTo: bottomToolBarView.centerYAnchor).isActive = true

        playVideoButton.translatesAutoresizingMaskIntoConstraints = false

        playVideoButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        playVideoButton.setTitle(PlayStatus.play.rawValue, for: .normal)

        playVideoButton.titleLabel?.adjustsFontSizeToFitWidth = true

        playVideoButton.titleLabel?.textColor = .white

        playVideoButton.addTarget(self, action: #selector(touchPlayVideoButton(_:)), for: .touchUpInside)

    }

    func setUpMuteVideoButton() {

        bottomToolBarView.addSubview(muteVideoButton)

        muteVideoButton.trailingAnchor.constraint(equalTo: bottomToolBarView.trailingAnchor, constant: -16).isActive = true

        muteVideoButton.centerYAnchor.constraint(equalTo: bottomToolBarView.centerYAnchor).isActive = true

        muteVideoButton.translatesAutoresizingMaskIntoConstraints = false

        muteVideoButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        muteVideoButton.setTitle("Mute", for: .normal)

        muteVideoButton.titleLabel?.adjustsFontSizeToFitWidth = true

        muteVideoButton.titleLabel?.textColor = .white

        muteVideoButton.addTarget(self, action: #selector(touchMuteVideoButton(_:)), for: .touchUpInside)

    }

    func setUpGestureRecognize() {

        let tapOutsideOfSearchBar: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.dismissKeyboard))

        view.addGestureRecognizer(tapOutsideOfSearchBar)

    }

    func dismissKeyboard() {

        view.endEditing(true)
    }

    func touchPlayVideoButton(_ sender: UIButton) {

        if sender.titleLabel?.text == PlayStatus.play.rawValue {

            self.player?.play()

        } else {

            self.player?.pause()

        }

    }

    func touchMuteVideoButton(_ sender: UIButton) {

        if sender.titleLabel?.text == "Mute" {

            self.player?.isMuted = true

        } else {

            self.player?.isMuted = false

        }

    }

}

extension VideoPlayerViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        guard let searchBarResultString = videoSearchBar.text,
              let searchBarResultURL = URL(string: searchBarResultString)
              else { return }

        let player = AVPlayer(url: searchBarResultURL)

        player.addObserver(self, forKeyPath: "rate", options: .new, context: nil)

        self.player = player

        player.play()

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()

    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "rate" {

            if playVideoButton.titleLabel?.text == PlayStatus.play.rawValue {

                playVideoButton.setTitle(PlayStatus.pause.rawValue, for: .normal)

            } else {

                playVideoButton.setTitle(PlayStatus.play.rawValue, for: .normal)

            }

            if player?.isMuted == true {

                muteVideoButton.setTitle("Unmute", for: .normal)

            } else {

                muteVideoButton.setTitle("Mute", for: .normal)

            }

        }

    }

}
