class rgbank::web::docker::image {

  # overrides service providers to work in container context
  include dummy_service

  rgbank::web::base { 'docker-image':
    version          => hiera('rgbank-build-version', 'master'),
    source           => hiera('rgbank-build-path', 'https://github.com/puppetlabs/rgbank'),
    listen_port      => '80',
    install_dir      => '/opt/rgbank-web',
    custom_wp_config => file('rgbank/wp-config.php.docker'),
  }
}
