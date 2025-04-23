import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let pages = [CustomPageViewController(), CustomPageViewController(), CustomPageViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self

        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! CustomPageViewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! CustomPageViewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }

    // MARK: - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentViewController = viewControllers?.first else { return }
            
            // 前のページを解放
            for previousViewController in previousViewControllers {
                if let previous = previousViewController as? CustomPageViewController {
                    previous.cleanupResources()
                }
            }

            // 現在のページを初期化
            if let current = currentViewController as? CustomPageViewController {
                current.resetToInitialState()
            }
        }
    }
}

class CustomPageViewController: UIViewController {
    func resetToInitialState() {
        print("Page initialized")
        // ページの初期化処理を記述
    }

    func cleanupResources() {
        print("Cleaning up resources")
        // イベントリスナーの解除やタスクの停止など
    }
}
