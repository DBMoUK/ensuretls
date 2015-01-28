class profile::ensuretls::db {

  $encryptionmode = hiera('profile::ensuretls::encryptionmode',{})

  include ensuretls::db

}
