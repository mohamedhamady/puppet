node 'wiki' {
    $wikisitename = 'wiki'
    $wikisitenamespace = 'wiki'
    $wikiserver = 'http://192.168.2.20'
    $wikidbserver = 'localhost'
    $wikidbname = 'wikidb'
    $wikidbuser = 'root'
    $wikidbpassword = 'strongpassword'
    $wikiupgradekey = 'puppet'
    class { 'linux': }
    class { 'mediawiki': }
}

node 'wikitest' {
    class { 'linux': }
    class { 'mediawiki': }
}

class linux {

    $admintools = ['git', 'nano', 'screen']

    package { $admintools:
         ensure => 'installed',
    }

    $ntpservice = $osfamily ? {
        'redhat' => 'ntpd',
        'debian' => 'ntp',
        default => 'ntp',
    }

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
