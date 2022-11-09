<?php
	
function connect_bdd() {
	$conn = new mysqli('127.0.0.1', 'CTF_reseau_site', 'q9mChiFtU4YC2568', 'CTF_reseau_site');

	if ($conn->connect_errno) {
		die("Connexion a echoue". $conn->connect_errno);
	}
	return $conn;
}

function postReview() {
	$mysqli = connect_bdd();

	$tmp1 = htmlentities($_POST['email'], ENT_QUOTES | ENT_IGNORE, "UTF-8");
	$tmp2 = htmlentities($_POST['avis'], ENT_QUOTES | ENT_IGNORE, "UTF-8");
	$tmp3 = 5;
	$tmp4 = $_SERVER['REMOTE_ADDR'];

	$query = $mysqli->prepare('INSERT INTO reviews VALUES(0, (?), (?), (?), (?))');
	$query->bind_param(
		"ssis",
		$tmp1,
		$tmp2,
		$tmp3,
		$tmp4
	);

	$query->execute();

	redirection("accueil");
}

function postPrescription() {
	$target_dir = "prescriptions/";
	$target_file = $target_dir . basename($_FILES["file"]["name"]);
	$check = getimagesize($_FILES["file"]["tmp_name"]);

	if($check !== false && $check["mime"] == "image/png") {
		if (file_exists($target_file))
			return 2;
		if (!move_uploaded_file($_FILES["file"]["tmp_name"], $target_file))
			return 3;
  	} else {
    	return 1;
	}

	$mysqli = connect_bdd();

	$tmp1 = htmlentities($_POST['email'], ENT_QUOTES | ENT_IGNORE, "UTF-8");
	$tmp2 = $_SERVER['REMOTE_ADDR'];

	$query = $mysqli->prepare('INSERT INTO prescriptions VALUES(0, (?), (?), (?))');
	$query->bind_param(
		"sss",
		$tmp1,
		$target_file,
		$tmp2
	);

	$query->execute();

	return 0;
}