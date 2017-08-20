Pod::Spec.new do |s|
  s.name             = "UIUCDiningHallScraper"
  s.version          = "0.1.0"
  s.summary          = "haha"
  s.homepage         = "https://xgbn.github.io"
  s.license          = {type: "MIT", file: "LICENSE"}
  s.author           = { "Xiangbin Hu" => "hu.xgbn@gmail.com" }
  s.source           = {git: "https://github.com/Xgbn/UIUCDiningHallScraper.git", tag:"0.1.0"}

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files  = ['Sources/**/*.swift', 'Sources/**/*.h']

  s.dependency 'Kanna', '~> 2.1.0'
  s.dependency 'Alamofire', '~> 4.4'
end
