void main() {

	int totalSchool = 5;
	int cumulativeSchool = 0;

	for(int i = 1; i <= 12; i++) {

		cumulativeSchool += (totalSchool * i);

		print(
			"i -> " +
			i.toString() +
			" -> " +
			(totalSchool * i).toString() +
			" -> " +
			cumulativeSchool.toString() +
			" -> " +
			(cumulativeSchool * 6200).toString()
		);
	}
}