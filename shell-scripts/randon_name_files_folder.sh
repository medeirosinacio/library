#!/bin/bash
# OS: Windowns 10
# Desc: Synchronize git repositories bash script
# Autor: Douglas Medeiros <medeirosinacio@outlook.com>
# Exemple to use: ./sync_repository.sh https://oauth2:XXXxxxXXXxxXXX@gitlab.com:name/repo.git git@gitlab.com:name/repo.git

DATE=$(date +"%d-%m-%Y-%H-%M-%S-%s")
FOLDER_TEMP="sync_repository-${DATE}"


#<?php
#
#function trueScandir($directory)
#{
#	$result = [];
#	$cdir = scandir($directory);
#	foreach ($cdir as $key => $value) {
#		if (!in_array($value, array(".", ".."))) {
#			if (is_dir($directory . DIRECTORY_SEPARATOR . $value)) {
#				$result[$value] = trueScandir($directory . DIRECTORY_SEPARATOR . $value);
#			} else {
#				$result[] = str_replace('.php', '', $value);
#			}
#		}
#	}
#
#	return $result;
#}
#
#function generateRandomString($length = 30, $sufix = '') {
#    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
#    $charactersLength = strlen($characters);
#    $randomString = '';
#    for ($i = 0; $i < $length; $i++) {
#        $randomString .= $characters[rand(0, $charactersLength - 1)];
#    }
#    return $randomString . $sufix;
#}
#echo 'start<br>';
#foreach(trueScandir(__DIR__ . "/music" as $file)){
#	echo $file . ' | OLD NAME<br>';
#	echo generateRandomString() . ' | OLD NAME<br><br><br>';
#	//rename(__DIR__ . "/music/{$file}", generateRandomString());
#}
#echo 'end<br>';