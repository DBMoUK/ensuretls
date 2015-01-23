class profiles::ensuretls::params {
  $encryptionmode = hiera('profiles::ensuretls::encryptionmode',{})
}
