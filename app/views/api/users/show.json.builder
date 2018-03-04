#一覧表示
# とりあえずユーザの部分だけ
json.set! :user do
  json.extract! @user, :id,:account,:passwordt
end