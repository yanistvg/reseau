function changeStarView(selectedStar) {
	var viewStars = document.getElementsByClassName('star-view');
	var checkStars = document.getElementsByClassName('star-icon');

	for(var i=0; i <= selectedStar; i++) {
		viewStars[i].classList.add("valid-star");
		checkStars[i].checked = true;
	}
	for(var i=selectedStar; i < 5; i++) {
		viewStars[i].classList.remove("valid-star");
		checkStars[i].checked = false;
	}
	viewStars[selectedStar].classList.add("valid-star");
}
