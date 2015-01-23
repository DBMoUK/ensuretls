class profile::ensuretls {

  $encryptionmode = hiera('profile::ensuretls::encryptionmode',{})

  include ensuretls

}
