name             'candide'
maintainer       'Jeff Thomas'
maintainer_email 'jefferyjthomas@gmail.com'
license          'All rights reserved'
description      'Installs/Configures candide'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2", "~> 1.6.0"
depends "mysql", "~> 3.0.0"
depends "database", "~> 1.3.0"
depends "java", "~> 1.12.0"
depends "php", "~> 1.2.2"

