class docker {
        case $::osfamily{
                 "debian":{
                         exec{'Atualizar o repo':
                                 command => "/usr/bin/apt update"

                          }
                          $pacotes = ['apt-transport-https','ca-certificates','curl','software-properties-commom']
                          $repositorio = "/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | /usr/bin/apt-key add - ; /usr/bin/add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable' ; /usr/bin/apt update"

                 } 
                 "redhat": {
                         $pacotes = ['yum-utils','device-mapper-persistent-data','lvm2i']

                         $repositorio = "/bin/yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
                 }
	}

                 package{$pacotes:
                         ensure => present
                 }
                 exec {"adicionando repo":
                         command => $repositorio
                 }
                 package{"docker-ce":
                         ensure => present

                 }

                 service{"docker":
                         ensure => running,
                         enable => true,
                         require => Package["docker-ce"]
                 }
}
