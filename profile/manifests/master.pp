class profile::ensuretls::master {

  $jvmencryptionmode = hiera('profile::ensuretls::jvmencryptionmode',{})

  include ensuretls::master

}
