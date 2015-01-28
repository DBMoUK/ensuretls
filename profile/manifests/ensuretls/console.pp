class profile::ensuretls::db {
  class {'ensuretls::db':
    encrytptionmode => hiera('profile::ensuretls::encryptionmode'),
  }
}
