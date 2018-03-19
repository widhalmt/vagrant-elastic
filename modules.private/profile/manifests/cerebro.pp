# Idea for downloading with exec from https://stackoverflow.com/questions/18844199/how-to-fetch-a-remote-file-e-g-from-github-in-a-puppet-file-resource


class profile::cerebro {

  exec { 'download_cerebro':
    command => '/usr/bin/curl -L https://github.com/lmenezes/cerebro/releases/download/v0.7.2/cerebro-0.7.2.tgz > /opt/cerebro-0.7.2.tgz',
    creates => '/opt/cerebro-0.7.2.tgz',
  }
  exec { 'extract_cerebro':
    command => '/usr/bin/tar xf /opt/cerebro-0.7.2.tgz -C /opt',
    require => Exec["download_cerebro"],
    creates => '/opt/cerebro-0.7.2',
  }
}
