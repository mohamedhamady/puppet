$ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    default => 'ntp',
}

node 'wiki' {
    file { '/info.txt':
        ensure => 'present',
        content => inline_template("Created by Puppet at <%= Time.now %>\n"),
    }
    package { 'ntp':
        ensure => 'installed',
    }
    service { $ntpservice:
        ensure => 'running',
        enable => true,
    }
}

node 'wikitest' {
    package { 'ntp':
        ensure => 'installed',
    }
    service { $ntpservice:
        ensure => 'running',
        enable => true,
    }
}