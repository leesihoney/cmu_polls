# Uncomment the next line to define a global platform for your project
platform :ios, '13.1'

def base_pods
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'GoogleSignIn'
end

target 'CMUPoll' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
   use_frameworks!

  # Pods for CMUPoll
  base_pods

  target 'CMUPollTests' do
    inherit! :search_paths
  end

  target 'CMUPollUITests' do
    inherit! :complete
  end

end
