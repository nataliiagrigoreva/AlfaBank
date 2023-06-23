//
//  GameViewController.swift
//  AlfaBank
//
//  Created by Nataly on 23.06.2023.
//

import UIKit

class GameViewController: UIViewController {
    private var score: Int = 0
    private var timer: Timer?
    private var timeRemaining: Int = 10
    private var isGameRunning: Bool = false
    
        private let scoreLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 24)
            return label
        }()
        
        private let timerLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 32)
            return label
        }()
        
        private let restartButton: UIButton = {
            let button = UIButton(type: .custom)
            let startImage = UIImage(named: "start")
            button.setImage(startImage, for: .normal)
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
            return button
        }()
        
        private let bottomTextLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            label.textColor = .white
            label.text = "Поймай больше 5 Моргенов и будешь молодец. Ваганычей не лови!"
            return label
        }()
        
        private let congratsLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 48)
            label.textColor = .white
            label.isHidden = true
            return label
        }()
        
        private var objectImageView: UIImageView?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupBackground()
            setupViews()
            updateScoreLabel()
            adaptLayoutForScreenSize()
        }
        
        private func setupBackground() {
            let backgroundImage = UIImage(named: "FON.png")
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.frame = view.bounds
            view.addSubview(backgroundImageView)
            view.sendSubviewToBack(backgroundImageView)
        }
        
        private func setupViews() {
            view.addSubview(scoreLabel)
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            view.addSubview(timerLabel)
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            view.addSubview(restartButton)
            restartButton.translatesAutoresizingMaskIntoConstraints = false
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            view.addSubview(bottomTextLabel)
            bottomTextLabel.translatesAutoresizingMaskIntoConstraints = false
            bottomTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            bottomTextLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -10).isActive = true
            bottomTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            bottomTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            view.addSubview(congratsLabel)
            congratsLabel.translatesAutoresizingMaskIntoConstraints = false
            congratsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            congratsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            congratsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
        
        private func adaptLayoutForScreenSize() {
            let screenHeight = UIScreen.main.bounds.height
            
            if screenHeight < 667 { // Размер экрана меньше iPhone 8
                scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
                timerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
                restartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400).isActive = true
            } else if screenHeight > 667 { // Размер экрана больше iPhone 8
                scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
                timerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
                restartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -640).isActive = true
            }
        }
        
        @objc private func startGame() {
            if !isGameRunning {
                isGameRunning = true
                score = 0
                updateScoreLabel()
                startTimer()
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            adaptLayoutForScreenSize()
        }
        
        private func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timeRemaining = 15
            updateTimerLabel()
            spawnObject()
        }
        
        private func stopGame() {
            timer?.invalidate()
            timer = nil
            isGameRunning = false
            objectImageView?.removeFromSuperview()
            objectImageView = nil
        }
        
        private func updateScoreLabel() {
            scoreLabel.text = "Поймано: \(score)"
            scoreLabel.textColor = .white
        }
        
        private func updateTimerLabel() {
            timerLabel.text = "\(timeRemaining)"
            scoreLabel.textColor = .white
        }
        
        private func spawnObject() {
            let objectSize: CGFloat = CGFloat.random(in: 50...400)
            let screenWidth = view.bounds.width
            let screenHeight = view.bounds.height
            
            let minX = screenWidth * 0.25
            let maxX = screenWidth * 0.75
            let minY = screenHeight * 0.35
            let maxY = screenHeight * 0.53
            
            let randomX = CGFloat.random(in: minX...maxX)
            let randomY = CGFloat.random(in: minY...maxY)
            
            let imageView = UIImageView(frame: CGRect(x: randomX - objectSize / 2, y: randomY - objectSize / 2, width: objectSize, height: objectSize))
            
            let randomNumber = arc4random_uniform(2) // 0 or 1
            if randomNumber == 0 {
                imageView.image = UIImage(named: "Banana")
            } else {
                imageView.image = UIImage(named: "Shkurka")
            }
            
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleObjectTap(_:)))
            imageView.addGestureRecognizer(tapGesture)
            
            view.addSubview(imageView)
            objectImageView = imageView
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                imageView.removeFromSuperview()
                self.objectImageView = nil
            }
        }
        
        @objc private func handleObjectTap(_ sender: UITapGestureRecognizer) {
            guard let imageView = sender.view as? UIImageView else { return }
            
            if imageView.image == UIImage(named: "Shkurka") {
                score -= 2
            } else {
                score += 1
            }
            
            imageView.removeFromSuperview()
            updateScoreLabel()
            
            if score >= 5 && timeRemaining == 0 {
                showCongratsLabel()
            }
        }
        
        @objc private func updateTimer() {
            timeRemaining -= 1
            updateTimerLabel()
            
            if timeRemaining == 0 {
                stopGame()
                
                if score >= 5 {
                    showCongratsLabel()
                }
            } else {
                spawnObject()
            }
        }
        
        private func showCongratsLabel() {
            congratsLabel.text = "ТЫ МОЛОДЕЦ!"
            congratsLabel.isHidden = false
            congratsLabel.font = UIFont.boldSystemFont(ofSize: 40)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.congratsLabel.isHidden = true
            }
        }
    }




