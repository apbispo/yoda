class base {
	case $::osfamily{
		"redhat": {
			
			$pacotes = ["epel-release","git","vim","sysstat","htop","sl","figlet","fish"]
			$web = "httpd"
		}
		"debian": {

			exec{"atualiza_pacotes":
				command => "/usr/bin/apt update"

			}

			$pacotes = ["git","vim","sysstat","htop","ci	owsay","sl","figlet","fish"]
			$web = "apache2"
		}
	}

	package{$pacotes:
		ensure => present,
	}

#	file{'/root/.bashrc':
#		source => "puppet:///modules/base/bashrc_base",
#		ensure => present
#	}

	user{"devops":
		ensure => present,
		managehome => true,
		shell => "/usr/bin/fish"

	}
}

