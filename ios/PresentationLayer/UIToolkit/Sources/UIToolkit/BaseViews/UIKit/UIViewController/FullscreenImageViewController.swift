//
//  Created by Petr Chmelar on 16/10/2018.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

public final class FullscreenImageViewController: BaseViewController {
    
    // MARK: UI components
    private var scrollView = UIScrollView()
    private var imageView = UIImageView()
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: Inits
    public init(_ image: UIImage) {
        imageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    // MARK: Default methods
    override public func setupUI() {
        super.setupUI()
        
        view.backgroundColor = UIColor(AppTheme.Colors.background)
        activityIndicator.color = UIColor(AppTheme.Colors.progressView)
        imageView.contentMode = .scaleAspectFit
        scrollView.maximumZoomScale = 10.0
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}

extension FullscreenImageViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Center content of scrollView
        // Idea taken from: https://stackoverflow.com/a/36170800
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}
