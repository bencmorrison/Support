// Copyright © 2023 Ben Morrison. All rights reserved.

#if canImport(UIKit)

import UIKit

extension UIView {
    typealias ConstraintsClosure = (_ view: UIView, _ superview: UIView) -> [NSLayoutConstraint]
    
    @discardableResult
    func insertView(_ view: UIView, at index: Int, applyingConstraints applyConstraints: ConstraintsClosure) -> [NSLayoutConstraint] {
        insertSubview(view, at: index)
        return self.applyConstraints(applyConstraints, to: view)
    }
    
    @discardableResult
    func addSubview(_ view: UIView, applyingConstraints applyConstraints: ConstraintsClosure) -> [NSLayoutConstraint] {
        addSubview(view)
        return self.applyConstraints(applyConstraints, to: view)
    }
    
    @discardableResult
    func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView, applyConstraints: ConstraintsClosure) -> [NSLayoutConstraint] {
        insertSubview(view, belowSubview: siblingSubview)
        return self.applyConstraints(applyConstraints, to: view)
    }
    
    @discardableResult
    func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView, applyConstraints: ConstraintsClosure) -> [NSLayoutConstraint] {
        insertSubview(view, aboveSubview: siblingSubview)
        return self.applyConstraints(applyConstraints, to: view)
    }
    
    private func applyConstraints(_ applyConstraints: ConstraintsClosure, to view: UIView) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = applyConstraints(self, view)
        view.addConstraints(constraints)
        
        return constraints
    }
}

#endif
