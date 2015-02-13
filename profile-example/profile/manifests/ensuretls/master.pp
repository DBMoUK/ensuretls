class profile::ensuretls::master {

  class { '::ensuretls::master':

    jvmencryptionmode => hiera('profile::ensuretls::jvmencryptionmode')

  }

}
