Pod::Spec.new do |s|
s.name         = "DFQRCode"
s.version      = "0.1.0"
s.summary      = "DFQRCode"
s.homepage     = "https://github.com/ongfei/QRCode"
s.license      = 'MIT'
s.author       = { "ongfei" => "ong_fei@163.com" }
s.source       = { :git => "https://github.com/ongfei/QRCode.git", :tag => s.version.to_s }
s.platform      = :ios, '9.0'
s.source_files = 'QRCode/QRCode/QRCode/*'
s.requires_arc = true
s.dependency 'ZBarSDK'
end
