# ios-counting-label-demo
iOS ラベルを数値をカウントしていくサンプル(Swift3)

![to](https://cloud.githubusercontent.com/assets/9479568/25931513/ac1898fa-3647-11e7-97a2-3914cebb17be.gif)

## 使い方

1. CountingLabelを継承したUILabelを定義する

```swift:ViewController
@IBOutlet weak var label: CountingLabel!
```

2. countメソッドを呼ぶ

```swift:ViewController
        //0〜100まで1秒かけてカウントアップする
        label.count(fromValue: 0,
                    to: 100,
                    withDuration: 1,
                    andAnimationType: .EaseIn,
                    andCouterType: .Int)
```
