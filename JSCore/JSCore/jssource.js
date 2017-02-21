var helloWorld = "Hello World!"

function getFullname(firstname, lastname) {
	return firstname + " " + lastname;
}

function maxMinAverage(values) {
	var max = Math.max.apply(null, values);
	var min = Math.min.apply(null, values);

	var average = null;
	if (values.length > 0) {
		var sum = 0;
		for (var i = 0; i < values.length; i ++) {
			sum += values[i];
		}
		average = sum / values.length
	}
	
	return {
		"max": max,
		"min": min,
		"average": average
	}
}

function generateLuckyNumbers() {
	var luckyNumbers = [];
	
	while (luckyNumbers.length != 6) {
		var randomNumber = Math.floor((Math.random() * 50) + 1);
		
		if (!luckyNumbers.includes(randomNumber)) {
			luckyNumbers.push(randomNumber);
		}
	}
	
	handleLuckyNumbers(luckyNumbers);
}
