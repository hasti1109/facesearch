import 'package:facesearch/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF23395D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                child: Lottie.network('https://lottie.host/b68b53bc-4441-4da2-b7e2-84a0713e0068/ZCSAmHbc3t.json'),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Face Search',
                style: GoogleFonts.delaGothicOne(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Text(
                  'Explore a world of images like never before, with just a simple upload.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.signikaNegative(
                      fontSize: 18,
                      color: Colors.grey.shade300
                  ),
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF528AAE),
                ),
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 10,),

                      Icon(Icons.arrow_forward, color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
