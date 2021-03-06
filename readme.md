# DynamicVariable

  DynamicVariableは、アプリケーションを実行中に動的に変数の値を変えるためのライブラリです。
  HTTP通信により、rubyのswift-dvスクリプトから変数の値を書き換えられます。

  特にProjectの変更等することなく、簡単に利用できることが特徴です。

![dynamic_variable.gif](screenshots/dynamic_variable.gif)

* 使い方

```swift
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// httpサーバーの起動
		DynamicVariableManager.shared.start()
		return true
	}
```

```swift
class ViewController: UIViewController {
    
	@IBOutlet var label: UILabel!
	@IBOutlet var labelString: UILabel!
	
	override func viewDidLoad() {
        	// 初期値を3で、swift-dvからアクセスするための名称をvalでDynamicVariableを作成します。
		// callbackで、値が書き換わった際の処理を記述できます。
		// また書き換えた値は、Userdefaultsに保持されるので、次回起動時や、
		// 次回変数初期化時には、初期値3ではなく、前回書き換えられた値を使用します。
        	let val = 3.dv_bind(name: "val") { [weak self] (newValue) in
            		self?.label.text = "\(newValue)"
        	}

	        label.text = "\(val)"
        	labelString.text = "Text".dv_bind(name: "text", block: { (newValue) in
            		self.labelString.text = newValue
        	})

			let size = CGSize(width: 1, height: 2).dv_bind(name: "size") { [weak self] (newValue) in
			self?.labelSize.text = "\(newValue)"
			self?.labelSize.frame.size = newValue
		}
		self.labelSize.text = "\(size)"
        
		self.labelPoint.frame.origin = self.labelPoint.frame.origin.dv_bind(name: "origin") { [weak self] (point) in
			self?.labelPoint.text = "\(point)"
			self?.labelPoint.frame.origin = point
		}
		self.labelPoint.text = "\(self.labelPoint.frame.origin)"
	} 
```

* swift-dv

```sh
> swift_dv val 5 # 変数valを5に書き換えます。
```

* install方法
作成中
