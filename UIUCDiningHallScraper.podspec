Pod::Spec.new do |s|
  s.name             = "UIUCDiningHallScraper"
  s.version          = "0.1.0"
  s.summary          = "haha"
  s.homepage         = ""
  s.license          = 'MIT'
  s.author           = { "xiangbin" => "hu.xgbn@gmail.com" }
  s.source           = {}

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.preserve_path = 'Modules/*'
  s.source_files  = ['Sources/**/*.swift', 'Sources/**/*.h']
  s.xcconfig      = {
                      'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2',
                      'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Kanna/Modules'
                    }
end
