import 'package:flutter/material.dart';

class Sources extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
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



//                  SizedBox(height: 20),

//                  SingleChildScrollView(
//                    scrollDirection: Axis.horizontal,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//
//                        SymptomCard(
//                          image: "assets/cough.png",
//                          title: "Cough",
//                        ),
//                        SymptomCard(
//                          image: "assets/fever.png",
//                          title: "Fever",
//                        ),
//
//                        SymptomCard(
//                          image: "assets/shortness-of-breath.png",
//                          title: "Tiredness",
////                          isActive: true,
//                        ),
//                        SymptomCard(
//                          image: "assets/difficulty-breathing.png",
//                          title: "Difficulty Breathing",
////                          isActive: true,
//                        ),
//                      ],
//                    ),
//                  ),

                  Text("Developers", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  PreventCard(
                    image: "assets/kush1.jpg",
                    text: "- B.Tech CSE \n- III Year\n- Amity School of Engineering and Technology",
                    title: "Rahul Kushwaha",
                  ),
                  PreventCard(
                    text: "- B.Tech CSE \n- III Year\n- Amity School of Engineering and Technology",
                    image: "assets/lakshy.png",
                    title: "Lakshy Gupta",
                  ),
                  PreventCard(
                    text: "- B.Arch \n- I Year\n- Indian Institute of Technology, Roorkee",
                    image: "assets/sam.jpg",
                    title: "Dhwaj Gupta",
                  ),
                  SizedBox(height: 15),
                  Text("Sources", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  SourceCard(
                    title: "1. www.newsapi.org\n2. www.linkpe.in\n3. www.api.covid19api.com\n4. www.api.covid19india.org\n5. www.cdc.gov",
                  )

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


class SourceCard extends StatelessWidget {

  final String title;

  const SourceCard({
    Key key,

    this.title,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SizedBox(
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: double.infinity,
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


            Positioned(
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                height: 180,
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,),
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
