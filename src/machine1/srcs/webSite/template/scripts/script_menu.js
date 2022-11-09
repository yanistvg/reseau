
function closeMenu() {
	let menu = document.getElementsByClassName('menu-link')[0];
	menu.classList.remove('anim-open-menu');
	menu.classList.add('anim-close-menu');
	setTimeout(
		() => {
			menu.style.display="none";
			menu.classList.remove('anim-close-menu');
			document.getElementsByClassName('icon-menu')[0].onclick = openMenu;
		},
		1000
	);
}

function openMenu() {
	let menu = document.getElementsByClassName('menu-link')[0];
	menu.style.display="block";
	menu.classList.add('anim-open-menu');
	// menu.onClick="closeMenu()";
	document.getElementsByClassName('icon-menu')[0].onclick = closeMenu;
}
