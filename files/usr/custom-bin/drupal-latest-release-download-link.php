#!/usr/bin/php
<?php

$xml = simplexml_load_file('https://updates.drupal.org/release-history/drupal/8.x');

$latest = null;

foreach($xml->releases->release as $release) {
	if ($release->status != 'published') {
		continue;
	}

	if (property_exists($release, 'version_extra') && $release->version_extra != '') {
		continue;
	}

	if (!isset($latest) || $release->date > $latest->date) {
		$latest = $release;
	}
}

if (isset($latest) && property_exists($latest, 'download_link')) {
	echo $latest->download_link ."\n";
} else {
	error_log("ERROR: Drupal latest release download link not found");
	exit(999);
}
