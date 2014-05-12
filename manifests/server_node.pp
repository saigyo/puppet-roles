class roles::server_node {
  include profiles::java7
  include profiles::mysql
  include profiles::mongodb
  include profiles::nodejs
}