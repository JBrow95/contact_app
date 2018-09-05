const left = document.querySelector('.left');
const right = document.querySelector('.right');
const container = document.querySelector('.container');

left.addEventListener('mouseenter', () => {
	container.classList.add('hover-left');
});

left.addEventListener('mouseleave', () => {
	container.classList.remove('hover-left');
});

right.addEventListener('mouseenter', () => {
	container.classList.add('hover-right');
});

right.addEventListener('mouseleave', () => {
	container.classList.remove('hover-right');
});

function contactFunc() {
	var c = document.getElementById('display');
	if (c.style.display === "none") {
		c.style.display = "block";
		c.style.animation = "long 1s";
	} else {
		c.style.animation = "short 1s";
		c.style.display = "none";
	}
}