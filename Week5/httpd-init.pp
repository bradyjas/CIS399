class httpd {
    package {
        "httpd": ensure => installed
    }

    file { "/etc/httpd/conf/httpd.conf":
        source  => [
            "puppet:///modules/httpd/httpd.conf"
        ],
        mode    => 644,
        owner   => root,
        group   => root,
        require => Package["httpd"]
    }

    service { "httpd":
        enable     => true,
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        subscribe  => File["/etc/httpd/conf/httpd.conf"],
        require    => [
            Package["httpd"],
            File["/etc/httpd/conf/httpd.conf"]
        ]
    }
}
