define rgbank::web::docker(
  $db_name,
  $db_host,
  $db_user,
  $db_password,
  $docker_image,
  $listen_port,
  $image_tag = 'latest',
) {
  include docker

  # Only need one instance of the image per docker host
  if ! defined(Docker::Image[$docker_image]) {
    docker::image { $docker_image: }
  }

  docker::run { $name:
    image   => $docker_image,
    ports   => ["${listen_port}:80"],
    env     => [
      "DB_NAME=${db_name}",
      "DB_PASSWORD=${db_password}",
      "DB_USER=${db_user}",
      "DB_HOST=${db_host}",
    ],
    command => 'apachectl -DFOREGROUND',
  }
}
