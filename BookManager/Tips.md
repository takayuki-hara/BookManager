# Tips
ハマりどころをノウハウとして残しておく

## テーブルビューのセルのサイズを可変にする（Autolayoutの設定を使う）
viewDidLoad に下記のコードを入れる
	tableView.estimatedRowHeight = 108
	tableView.rowHeight = UITableViewAutomaticDimension
※固定の場合でも estimatedRowHeight は設定しないと崩れる

## スクロールビューが何故かズレる
下記で解決
http://mzgk.github.io/blog/2014/uiscrollview-checkpoint-2/
ほかにもいろいろパターンがありそう

## テキストエディットモードの解除
タッチジェスチャーを登録し、その中で view.endEditing(true) を呼ぶ
	override func viewDidLoad() {
			:
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: "closeSoftKeyboard")
		self.view.addGestureRecognizer(gestureRecognizer)
	}

	func closeSoftKeyboard() {
		self.view.endEditing(true)
	}

## テーブルビューがある時のテキストエディットモード解除
TableViewではUITapGestureRecognizerを使うとセルのタップが検知できない
そのためUIScrollViewのkeyboardDismissModeを設定する（Storyboardにて）


