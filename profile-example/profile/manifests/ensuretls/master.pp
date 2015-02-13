class profile::ensuretls::master {

  class { '::ensuretls::master':

    #jvmencryptionmode => hiera('profile::ensuretls::jvmencryptionmode')
    jvmencryptionmode => 'ssl-protocols: ["TLSv1"]',

  }

}
