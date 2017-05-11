//
//  CountingLabel.swift
//  ios-counting-label-demo
//
//  Created by Eiji Kushida on 2017/05/11.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CountingLabel: UILabel {

    let counterVelocity: Float = 3.0

    enum CounterAnimationType {
        case Linear // f(x) = x
        case EaseIn // f(x) = x^3
        case EaseOut // f(X) = (1-x)^3
    }

    enum CounterType {
        case Int
        case Float
    }

    var startNumber: Float = 0.0
    var endNumber: Float = 0.0
    var progress: TimeInterval!
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!
    var timer: Timer?

    var counterType: CounterType!
    var counterAnimationType: CounterAnimationType!

    var currentCounterValue: Float {
        if progress >= duration {
            return endNumber
        }

        let percentage = Float(progress / duration)
        let update = updateCounter(counterValue: percentage)

        return startNumber + (update * (endNumber - startNumber))
    }


    /// ラベルにカウンターを設定する
    ///
    /// - Parameters:
    ///   - fromValue: 開始する値
    ///   - toValue: 終了する値
    ///   - duration: アニメーションする時間(秒）
    ///   - animationType: アニメーションのタイプ
    ///   - counterType: 値のタイプ (Int or Float)
    func count (fromValue: Float,
                to toValue: Float,
                withDuration duration: TimeInterval,
                andAnimationType animationType: CounterAnimationType,
                andCouterType counterType: CounterType) {

        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate

        invalidateTimer()

        if duration == 0 {
            updateText(value: toValue)
            return
        }

        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(CountingLabel.updateValue),
                                     userInfo: nil,
                                     repeats: true)

    }

    /// 値を更新する
    func updateValue() {

        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now

        if progress >= duration {
            invalidateTimer()
            progress = duration
        }

        updateText(value: currentCounterValue)
    }


    /// ラベルのテキストを更新する
    ///
    /// - Parameter value: 値
    func updateText (value: Float) {

        switch counterType! {
        case .Int:
            self.text = "\(Int(value))"
        case .Float:
            self.text = String(format: "%.2f", value)
        }
    }

    /// カウンターを更新する
    ///
    /// - Parameter counterValue: 値
    /// - Returns: 表示する値
    func updateCounter (counterValue:  Float) -> Float {
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, counterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, counterVelocity)

        }
    }

    /// タイマーを停止する
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
