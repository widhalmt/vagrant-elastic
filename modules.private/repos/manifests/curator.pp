class repos::curator {
  
   case $::osfamily {

      'redhat': {

         yumrepo { 'curator-5.x':
            descr => 'Elastic Curator repository for 5.x packages',
            baseurl => 'http://packages.elastic.co/curator/5/centos/7',
            enabled => '1',
            gpgcheck => '1',
            gpgkey => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
         }

      } # RedHat

      default: {
         fail("Your operatingsystem ${::operatingsystem} is not supported.")
      }

   } # case

}

