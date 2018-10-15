Pod::Spec.new do |s|

  s.name         = "MungoHealer"
  s.version      = "0.1.0"
  s.summary      = "TODO: write short framework description"

  s.description  = <<-DESC
    TODO: Write long description.
                   DESC

  s.homepage     = "https://github.com/JamitLabs/MungoHealer"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Cihat Gündüz" => "cocoapods@cihatguenduez.de" }
  s.social_media_url   = "https://twitter.com/Dschee"

  s.ios.deployment_target = "12.0"
  s.tvos.deployment_target = "12.0"

  s.source       = { :git => "https://github.com/JamitLabs/MungoHealer.git", :tag => "#{s.version}" }
  s.source_files = "Frameworks/MungoHealer", "Frameworks/MungoHealer/**/*.swift"
  s.framework    = "Foundation"

  # s.dependency "HandyUIKit", "~> 1.6"
  # s.dependency "HandySwift", "~> 2.5"

end
