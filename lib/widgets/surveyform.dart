import 'package:flutter/material.dart'

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showDialog(String title, String content) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Align(
              alignment: Alignment.topRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1.0,
                child: Material(
                  color: Colors.white, // Ensuring Material design
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          content,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF727272),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        _Icon1to10(),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              'Not Likely at All',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF727272),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(), // This keeps the spacing between the two Text widgets
                            ),
                            Text(
                              'Very Likely',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF727272),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Rate PRUServices in the following areas:',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF202020), // Text color
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        StarRatingRow(text: 'Clear information and instructions'),
                        const SizedBox(height: 16.0),
                        StarRatingRow(text: 'User-friendly navigation'),
                        const SizedBox(height: 16.0),
                        StarRatingRow(text: 'Easy to complete transaction'),
                        const SizedBox(height: 16.0),
                        StarRatingRow(text: 'Engaging design and visuals'),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(''), // Specify 'child' here
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red, // Background color
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}