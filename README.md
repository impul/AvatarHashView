[![Build Status](https://travis-ci.com/impul/AvatarHashView.svg?branch=master)](https://travis-ci.com/impul/AvatarHashView)
[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/AvatarHashView/badge.png)](https://cocoadocs.org/docsets/AvatarHashView)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/AvatarHashView/badge.svg)](https://cocoadocs.org/docsets/AvatarHashView)
[![Badge w/ Licence](https://cocoapod-badges.herokuapp.com/l/AvatarHashView/badge.svg)](https://cocoadocs.org/docsets/AvatarHashView)

# AvatarHashView
Create user avatars withoud storing. Simple and easy to use.

<p float="left">
<img src="/resources/Avatars1.png" width="100"/>
<img src="/resources/Avatars2.png" width="100"/>
</p>

## Features
- Create user avatar
- Stor avatar to UIImage
## Installation
### CocoaPods
<p>To integrate AvatarHashView into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>
<pre><code class="ruby language-ruby">pod 'AvatarHashView'</code></pre>

### Carthage
To include AvatarHashView using [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "impul/AvatarHashView"
```
## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.
## How to use
First of all you can review Example target.
You can use AvatarHashView by setting UIView class on XIB or Storyboard:
```
@IBOutlet weak var avatarView: UIImageView!

...

avatarView.setUser(hash: "userId")
```
You also can use it directly in code
```Swift
let avatar = AvatarHashView(hash: "userId", frame: avatarFrame)
view.addSubview(avatar)
```
Store avatar to UIImage
```swift
let image = avatar.image
```
## License
AvatarHashView is released under the [MIT License](https://github.com/impul/AvatarHashView/blob/master/LICENSE).
