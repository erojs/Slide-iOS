//
//  ForceTouchGestureRecognizer.swift
//  AudioClip
//
//  Created by Won on 18/08/2018.
//  Copyright © 2018 Naver. All rights reserved.
//
import UIKit.UIGestureRecognizerSubclass

final class ForceTouchGestureRecognizer: UIGestureRecognizer {
    
    var touch: UITouch?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = UIGestureRecognizer.State.failed
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = UIGestureRecognizer.State.failed
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if let firstTouch = touches.first {
            handleTouch(firstTouch)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if let firstTouch = touches.first {
            handleTouch(firstTouch)
        }
    }
    
    func handleTouch(_ firstTouch: UITouch) {
        guard firstTouch.force != 0 && firstTouch.maximumPossibleForce != 0 else {
            return
        }
        
        let treshold: CGFloat = 0.7
        
        if firstTouch.force / firstTouch.maximumPossibleForce >= treshold {
            touch = firstTouch
            state = UIGestureRecognizer.State.recognized
            if #available(iOS 10.0, *) {
                HapticUtility.hapticActionWeak()
            }
        }
    }
}
