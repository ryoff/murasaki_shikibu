# MurasakiShikibu

MurasakiShikibuは、表記ゆれ問題解決のために、名寄せを行うことを目的としているgemです。

- 住所を全角数字で統一したい
- 名前は大文字に統一したい

など、DBへの保存前にフォーマットを統一するような用途を想定しています。

before callback などでもDB保存前の変換は可能ですが、変換後のvalueで検索するにはwhere文やfind_by文のたびに、明示的に変換する必要があります。

MurasakiShikibuでは、

````ruby
attribute :name, MurasakiShikibu::Type.new { |name| name.capitalize }

# Or

include MurasakiShikibu

murasaki_shikibu :country do |country|
  country.upcase
end
```

といった記述をすることで、 `保存前のフォーマット変更` `検索文字列のフォーマット変更` を統一で行います。

gem名は、校了や清書といった文学っぽいイメージから、日本を代表する作家・歌人から名付けています。

rails5ではAttributesAPIが使用できそうです
http://edgeapi.rubyonrails.org/classes/ActiveRecord/Attributes/ClassMethods.html

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'murasaki_shikibu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install murasaki_shikibu

## Usage

````ruby
class User < ActiveRecord::Base
  attribute :name, MurasakiShikibu::Type.new { |name| name.capitalize }
  attribute :address, MurasakiShikibu::Type.new { |address| address.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ') }
end

# Or if want to use DO-END

class User < ActiveRecord::Base
  include MurasakiShikibu

  murasaki_shikibu :name do |name|
    name.capitalize
  end
  murasaki_shikibu :address do |address|
    address.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
  end
end


user = User.new(name: 'ryoff', address: '東京1-2-3')
user.name    # Ryoff
user.address # 東京１-２-３

User.new(name: 'ryoff', address: '東京1-2-3').save
User.where(name: 'ryoff').first.try!(:name)           # Ryoff
User.find_by(name: 'ryoff').try!(:name)               # Ryoff
User.where(address: '東京1-2-3').first.try!(:address) # 東京１-２-３
User.find_by(address: '東京1-2-3').try!(:address)     # 東京１-２-３
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

