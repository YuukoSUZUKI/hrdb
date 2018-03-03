# employees.json にアクセスすると、このjbuilderが呼ばれる

json.employees do
  # json.array!(配列) do |要素名| end を使うと、
  # 配列構造を作ることができる
  json.array!(@employees) do |employee|
    # json.partial! モデル変数 を使うと、
    # 部分テンプレートを表示する
    json.partial!(employee)
  end
end