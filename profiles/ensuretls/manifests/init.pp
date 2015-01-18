class profiles::ensuretls {

  $encryptionmode = hiera('profiles::ensuretls::encryptionmode',{})

  include ensuretls

}
