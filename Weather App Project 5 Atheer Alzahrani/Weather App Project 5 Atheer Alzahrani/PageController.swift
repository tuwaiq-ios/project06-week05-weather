//
//  PageController.swift
//  Weather App Project 5 Atheer Alzahrani
//
//  Created by Eth Os on 21/03/1443 AH.
//

import UIKit

class PageController: UIViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController = UIPageViewController(transitionStyle: .pageCurl , navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self

        addChild(pageController)
        view.addSubview(pageController.view)

        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))

        
        let vc1 = BaliViewController()
        let vc2 = WeatherViewController()
        let vc3 = RiyadhViewController()
        let vc4 = DammamViewController()
        
        controllers.append(vc2)
        controllers.append(vc3)
        controllers.append(vc4)
        controllers.append(vc1)
        

    pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
                  if index > 0 {
                      return controllers[index - 1]
                  } else {
                      return nil
                  }
              }

              return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
                   if index < controllers.count - 1 {
                       return controllers[index + 1]
                   } else {
                       return nil
                   }
               }

               return nil
    }
    
}

