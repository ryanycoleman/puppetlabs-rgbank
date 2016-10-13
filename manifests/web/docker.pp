define rgbank::web::docker(
  $db_name,
  $db_host,
  $db_user,
  $db_password,
  $docker_image,
  $listen_port,
  $image_tag          = 'latest',
  $docker_expose_port = hiera('rgbank-docker-expose-port', '80')
) {
  include docker

  # Only need one instance of the image per docker host
  if ! defined(Docker::Image[$docker_image]) {
    docker::image { $docker_image: }
  }

  docker::run { $name:
    image   => $docker_image,
    ports   => ["${listen_port}:${docker_expose_port}"],
    env     => [
      "DB_NAME=${db_name}",
      "DB_PASSWORD=${db_password}",
      "DB_USER=${db_user}",
      "DB_HOST=${db_host}",
    ],
    command => 'apachectl -DFOREGROUND',
  }
}
