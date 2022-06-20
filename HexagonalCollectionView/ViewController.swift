//
//  ViewController.swift
//  HexagonalCollectionView
//
//  Created by Mohtasim Abrar Samin on 28/3/22.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    let cellHeight: CGFloat = 160.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Hello"
        
        let layout = CustomeLayout()
        layout.delegate = self
        
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        activateLayoutConstraints()
    }
    
    func activateLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
}

extension ViewController: CustomLayoutDelagate {
    func collectionView( _ collectionView: UICollectionView, heightForCellAtIndexPath indexPath:IndexPath) -> CGFloat {
        return collectionView.frame.width / 2.0
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did Select Row at \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.title.text = "hello \(indexPath.row)"
        
        let path = UIBezierPath()
        
        let height = collectionView.frame.width / 2.0
        
        
        if ((indexPath.row + 1) % 3 == 0) {
            let width = collectionView.frame.width - 12
            path.move(to: CGPoint(x: width/2, y: 0))
            path.addLine(to: CGPoint(x: (3/4)*width-3, y: (height/7)*1.9))
            path.addLine(to: CGPoint(x: (3/4)*width-3, y: (height/7)*5.1))
            path.addLine(to: CGPoint(x: width/2, y: height))
            path.addLine(to: CGPoint(x: (width/4)+3, y: (height/7)*5.1))
            path.addLine(to: CGPoint(x: (width/4)+3, y: (height/7)*1.9))
            path.addLine(to: CGPoint(x: width/2, y: 0))
            path.close()
        } else {
            let width = collectionView.frame.width/2.2
            path.move(to: CGPoint(x: width/2, y: 0))
            path.addLine(to: CGPoint(x: width, y: (height/7)*1.9))
            path.addLine(to: CGPoint(x: width, y: (height/7)*5.1))
            path.addLine(to: CGPoint(x: width/2, y: height))
            path.addLine(to: CGPoint(x: 0, y: (height/7)*5.1))
            path.addLine(to: CGPoint(x: 0, y: (height/7)*1.9))
            path.addLine(to: CGPoint(x: width/2, y: 0))
            path.close()
        }
        
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        cell.layer.mask = shape
        return cell
    }
    
}

