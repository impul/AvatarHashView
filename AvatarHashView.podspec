Pod::Spec.new do |s|
  s.name         = "AvatarHashView"
  s.version      = "0.1.0"
  s.summary      = "Avatar Hash View"

  s.description  = <<-DESC
    Create user avatars without storing
                   DESC

  s.homepage     = "https://github.com/impul/AvatarHashView.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "impul" => "pavlo.bojkoo@gmail.com" }

  s.swift_version= '5'
  s.static_framework  = true

  s.ios.deployment_target = "11.0"

  s.source       = { :git => "https://github.com/impul/AvatarHashView.git", :tag => "#{s.version}" }

  s.module_name   = "AvatarHashView"
  s.source_files  = "Sources/**/*.swift"

end