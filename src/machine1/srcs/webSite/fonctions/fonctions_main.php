<?php

function redirection($page) {
	header('Location: index.php?page='.$page);
	exit(0);
}

function draw_page($page, $all_page, $errors) {
	if (!in_array($page, $all_page, true))
		redirection($all_page[0]);

	require_once("template/templates/templates_".$page.".php");
}