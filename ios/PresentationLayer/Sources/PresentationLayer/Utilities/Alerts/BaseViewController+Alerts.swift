//
//  Created by Petr Chmelar on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension BaseViewController {
    
    /// Handle alert on current top ViewController based on a given AlertAction.
    func handleAlertAction(_ action: AlertAction) {
        switch action {
        case let .showWhisper(whisper):
            showWhisper(whisper)
        case .hideWhisper:
            hideWhisper()
        case let .showAlert(alert):
            showAlert(alert)
        }
    }
    
    /// Present UIAlertController on current top ViewController.
    func showAlert(_ alert: Alert, textFieldHandler: ((UITextField) -> Void)? = nil) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(alert.primaryAction)
        
        if let secondaryAction = alert.secondaryAction {
            alertController.addAction(secondaryAction)
        }
        
        if textFieldHandler != nil {
            alertController.addTextField(configurationHandler: textFieldHandler)
        }
        
        hideWhisper()
        present(alertController, animated: true, completion: nil)
    }
    
    /// Present WhisperView on current top ViewController.
    func showWhisper(_ whisper: Whisper) {
        let whisperView = WhisperView(frame: CGRect(
            x: 0,
            y: -view.safeAreaInsets.top - 25,
            width: view.bounds.width,
            height: view.safeAreaInsets.top + 25
        ))
        whisperView.message = whisper.message
        whisperView.backgroundColor = whisper.style.color
        
        hideWhisper()
        view.addSubview(whisperView)
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveLinear,
            animations: { whisperView.frame.origin.y = 0 },
            completion: nil
        )
        
        if whisper.hideAfter > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + whisper.hideAfter) {
                self.hideWhisper()
            }
        }
    }
    
    /// Hide and remove WhisperView from current top ViewController.
    func hideWhisper() {
        for view in view.subviews where view.isKind(of: WhisperView.self) {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveLinear,
                animations: { view.frame.origin.y = -view.safeAreaInsets.top - 30 },
                completion: { _ in view.removeFromSuperview() }
            )
        }
    }
    
}
