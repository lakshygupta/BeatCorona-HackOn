import 'package:flutter/material.dart';


class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Percautions'),
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[

                  Text(
                    "Symptoms",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        SymptomCard(
                          image: "assets/cough.png",
                          title: "Cough",
                        ),
                        SymptomCard(
                          image: "assets/fever.png",
                          title: "Fever",
                        ),

                        SymptomCard(
                          image: "assets/shortness-of-breath.png",
                          title: "Tiredness",
//                          isActive: true,
                        ),
                        SymptomCard(
                          image: "assets/difficulty-breathing.png",
                          title: "Difficulty Breathing",
//                          isActive: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text("Preventions", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                    "Avoid close contact with people who are sick and Stay Home as much as possible.",
                    image: "assets/protect-quarantine.png",
                    title: "Avoid close contact",
                  ),
                  PreventCard(
                    text:
                    "Wash your hands often with soap and water for at least 20 seconds especially after you have been in a public place.",
                    image: "assets/protect-wash-hands.png",
                    title: "Wash your hands",
                  ),
                  PreventCard(
                    text:
                    "Everyone should wear a cloth face cover when they have to go out in public, for example to the grocery store.",
                    image: "assets/cloth-face-cover.png",
                    title: "Wear Mask",
                  ),
                  PreventCard(
                    text:
                    "Remember to cover your mouth and nose when you cough or sneeze or use the inside of your elbow.",
                    image: "assets/COVIDweb_06_coverCough.png",
                    title: "Cover your mouth",
                  ),
                  PreventCard(
                    text:
                    "Clean AND disinfect frequently touched surfaces daily. Use detergent or soap and water prior to disinfection.",
                    image: "assets/COVIDweb_09_clean.png",
                    title: "Clean and disinfect",
                  ),
                  SizedBox(height: 60),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 180,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 15,

                  ),
                ],
              ),
            ),
            Image.asset(image, width: 140.0,height: 300.0,),
//            Image.asset(image, alignment: Alignment.center,),

            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 145,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    new Divider(),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
//                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 150.0,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
//            color: kActiveShadowColor,
          )
              : BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 3,
//            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image,),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}