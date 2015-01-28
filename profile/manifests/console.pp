class profile::ensuretls::console {

  $encryptionmode = hiera('profile::ensuretls::encryptionmode',{})

  include ensuretls::console

}
