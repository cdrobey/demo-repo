# gogs
#
# Use gogs modules to install GOGS Git Server.
#
# @summary  This profiles installs an internal Git Server to support localize development.
#
# @param    secret_key - a password to setup and configure GOGS Server
#
# @example
#   include profile::appc or assign in PE classifier
# == Class: profile::apps::gogs
class profile::apps::gogs {
  $secret_key = 'mysecretkey'

  class {'::gogs':
    version          => '0.11.19',
    app_ini          => {
      'APP_NAME' => 'Local Git Server',
      'RUN_USER' => 'git',
      'RUN_MODE' => 'prod',
    },
    app_ini_sections => {
      'server'     => {
        'DOMAIN'           => $::fqdn,
        'HTTP_PORT'        => 80,
        'ROOT_URL'         => "https://${::fqdn}/",
        'HTTP_ADDR'        => '0.0.0.0',
        'DISABLE_SSH'      => false,
        'SSH_PORT'         => '22',
        'START_SSH_SERVER' => false,
        'OFFLINE_MODE'     => false,
      },
      'database'   => {
        'DB_TYPE'  => 'sqlite3',
        'HOST'     => '127.0.0.1:3306',
        'NAME'     => 'gogs',
        'USER'     => 'root',
        'PASSWD'   => '',
        'SSL_MODE' => 'disable',
        'PATH'     => '/opt/gogs/data/gogs.db',
      },
      'security'   => {
        'SECRET_KEY'   => 'thesecretkey',
        'INSTALL_LOCK' => true,
      },
      'service'    => {
        'REGISTER_EMAIL_CONFIRM' => false,
        'ENABLE_NOTIFY_MAIL'     => false,
        'DISABLE_REGISTRATION'   => false,
        'ENABLE_CAPTCHA'         => true,
        'REQUIRE_SIGNIN_VIEW'    => false,
      },
      'repository' => {
        'ROOT'     => '/var/git',
      },
      'mailer'     => {
        'ENABLED' => false,
      },
      'picture'    => {
        'DISABLE_GRAVATAR'        => false,
        'ENABLE_FEDERATED_AVATAR' => true,
      },
      'session'    => {
        'PROVIDER' => 'file',
      },
      'log'        => {
        'MODE'      => 'file',
        'LEVEL'     => 'info',
        'ROOT_PATH' => '/opt/gogs/log',
      },
      'webhook'    => {
        'SKIP_TLS_VERIFY' => true,
      },
    },
    manage_user      => true,
  }

  firewall{ '100 allow web connections':
    proto  => 'tcp',
    dport  => 80,
    action => accept,
  }
}

