function greet(name) {
	if (name.length === 0) {
		return "Hello World!";
	}
	return `Hello ${name}!`;
}

module.exports = { greet };
