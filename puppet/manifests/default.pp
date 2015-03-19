Exec {
	path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

exec { 'apt-get_update':
	command      => 'apt-get update',
}

package {
	['php5', 'curl', 'git']:
		ensure		=> installed,
		require		=> [Exec['apt-get_update']]
}

exec { 'composer':
	command		=> 'curl -sS https://getcomposer.org/installer | php -- --filename=composer',
	cwd			=> '/usr/bin',
	require		=> [Package['php5'], Package['curl']]
}

exec { 'phpunit':
	command			=> 'composer require phpunit/phpunit',
	cwd				=> '/kata',
	environment		=> ["COMPOSER_HOME=/usr/bin"],
	require			=> [Exec['composer']]
}