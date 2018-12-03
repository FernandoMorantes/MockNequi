if Gem::Platform.local.os == 'linux'
  system('sudo gem install bundler')
else
  system('gem install bundler')
end
system('bundle install')