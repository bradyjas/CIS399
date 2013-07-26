class postfix {
    package {
        "postfix": ensure => installed
    }

    file { "/etc/postfix":
        source  => "puppet:///modules/postfix",
        recurse => true,
        mode    => 644,
        owner   => root,
        group   => root,
        require => Package["postfix"]
    }

    service { "postfix":
        enable     => true,
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        subscribe  => File["/etc/postfix"],
        require    => [
            Package["postfix"],
            File["/etc/postfix"]
        ]
    }
}
