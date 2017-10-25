node {
    git 'https://github.com/cdrobey/puppet-repo'

    puppet.credentials 'pe-access-token'

    stage ('Checkout Control Repo') {
      checkout scm
    }

    stage ('Check Style - Lint') {
      sh 'echo $(find . -type f -name "*.pp" \\( -exec /opt/puppetlabs/puppet/bin/puppet-lint --with-filename {} \\; -o -quit \\) 2>&1 ) | grep -v ERROR'
    }

    stage ('Check Syntax - Parse') {
      sh 'echo $(find . -type f -name "*.pp" \\( -exec /opt/puppetlabs/bin/puppet parser validate {} \\; -o -quit \\) 2>&1 ) | grep -v Error'
    }

    stage ('Authorize deployment') {
      puppet.credentials 'pe-access-token'
    }

    stage ('Deploy to production') {
      puppet.codeDeploy 'production'
    }
}