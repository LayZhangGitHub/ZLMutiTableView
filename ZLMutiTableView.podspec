Pod::Spec.new do |s|
  s.name         = "ZLMutiTableView"
  s.version      = "1.1.5"
  s.summary      = "多表格 ZLMutiTableView."

  s.description  = <<-DESC
  A longlonglonglong description of ZLMutiTableView.
                   DESC

  s.homepage     = "https://github.com/githubforzhanglei/ZLMutiTableView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  s.author       = { "githubforzhanglei" => "zhanglei19910607@163.com" }
  s.source       = { :git => "https://github.com/githubforzhanglei/ZLMutiTableView.git", :tag => s.version.to_s }

  s.ios.deployment_target = '6.0'

  s.source_files  = "ZLMutiTableView/**/*"

end
