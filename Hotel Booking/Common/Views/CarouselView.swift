//
//  CarouselView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 03.09.2023.
//

import UIKit

class CarouselView: UIView {
    
    // MARK: - Subviews
    
    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        collection.backgroundColor = .clear
        collection.layer.cornerRadius = 15
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .prominent
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Properties
    
    private var carouselData: [UIImage] = []
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    // MARK: - Override methods
    
    override func layoutSubviews() {
        setupLayout()
    }
    
}

// MARK: - UICollectionViewDataSource

extension CarouselView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
        
        let image = carouselData[indexPath.row]
        
        cell.configure(image: image)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CarouselView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
}
// MARK: - Public methods

extension CarouselView {
    
    public func configureView(data: [UIImage]) {
        carouselData = data
        pageControl.numberOfPages = data.count
        activityIndicator.stopAnimating()
        carouselCollectionView.reloadData()
    }
    
}

// MARK: - Private methods

private extension CarouselView {
    
    func getCurrentPage() -> Int {
        
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
    
    func setupLayout() {
        addSubview(activityIndicator)
        addSubview(carouselCollectionView)
        addSubview(pageControl)

        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        carouselCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let cellWidth = self.frame.width
        let cellHeight = self.frame.height
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewFlowLayout.minimumLineSpacing = 0
        
        return collectionViewFlowLayout
    }
}




