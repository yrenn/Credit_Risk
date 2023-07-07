# Credit_Risk

## background
The Office of the Superintendent of Financial Institutions (OSFI) has raised a new set of requirements to direct the usage of external credit assessments by big banks. After a review process of the major international rating agencies, OSFI has permitted banks to recognize credit ratings from the following rating agencies for capital adequacy purposes.

- DBRS
- Moody’s Investors Service
- Standard and Poor’s (S&P)
- Fitch Rating Services

Each bank will be responsible for assigning eligible External Credit Assessment Institutions (ECAIs)’ assessments to the risk weights available under the standardized risk weighting framework, i.e. deciding which assessment categories correspond to which risk weights. The mapping process should be objective and should result in a risk weight assignment consistent with that of the level of credit risk reflected in the tables above. It should cover the full spectrum of risk weights. The following table provides guidance as to how such a mapping process may be conducted:


RTG_MOODY	RTG_SP	RTG_DBRS	RTG_FITCH	IG
Aaa	AAA	AAA	AAA	99
Aa1	AA+	AAH	AA+	98
Aa2	AA	AA	AA	96
Aa3	AA-	AAL	AA-	95
A1	A+	AH	A+	94
A2	A	A	A	92
A3	A-	AL	A-	90
Baa1	BBB+	BBBH	BBB+	87
Baa2	BBB	BBB	BBB	85
Baa3	BBB-	BBBL	BBB-	83
Ba1	BB+	BBH	BB+	80
Ba2	BB	BB	BB	77
Ba3	BB-	BBL	BB-	75
B1	B+	BH	B+	73
....


Rules:
• If there is only one assessment by an ECAI chosen by a bank for a particular claim, that assessment should be used to determine the risk weight of the claim.
• If there are two assessments by ECAIs chosen by a bank which map into different risk weights, the higher risk weight will be applied.
• If there are three or more assessments with different risk weights, the assessments corresponding to the two lowest risk weights should be referred to and the higher of those two risk weights will be applied.
• For the instrument issued by US or Canadian government, if there is no external rating available, default the grade to 'AAA'.
• For the instrument issued by other foreign government, if there is no external rating available, default the grade to ‘A'


lesson learned:

