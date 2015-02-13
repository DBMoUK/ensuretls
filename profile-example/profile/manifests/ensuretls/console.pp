class profile::ensuretls::console {

  class { '::ensuretls::console':

    encryptionmode => hiera('profile::ensuretls::encryptionmode',{})

  }
}
