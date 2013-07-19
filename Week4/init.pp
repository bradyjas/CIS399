class sshd {
        package {
                "openssh-server": ensure => installed;
        }

        file { "/etc/ssh/sshd_config":
                source  => [
                        "puppet:///modules/sshd/sshd_config",
                ],
                mode    => 400,
                owner   => root,
                group   => root,
                require => Package["openssh-server"],
        }

        service { "sshd":
                enable     => true,
                ensure     => running,
                hasstatus  => true,
                hasrestart => true,
                require    => [ Package["openssh-server"],
                                File["/etc/ssh/sshd_config"] ],
                subscribe  => File["/etc/ssh/sshd_config"],
        }
}
