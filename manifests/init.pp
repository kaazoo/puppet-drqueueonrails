class drqueueonrails {
  $git_branch = "rails3_mongodb"
  $ruby_version = "1.8.7-p358"
  $passenger_version = "3.0.12"
  include drqueueonrails::config, drqueueonrails::install
}
