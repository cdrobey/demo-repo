# == Class: role::jenkins
#
class role::jenkins {
  # resources
  #All roles should include the base profile
  include profile::linux
  include profile::jenkins
}
