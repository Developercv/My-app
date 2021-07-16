import 'package:flutter/material.dart';
import 'package:learner/model.dart';
import 'dart:convert';
import 'package:http/http.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<QueryModel> modelList = <QueryModel>[];
  bool isLoading = true;

  getByQuery() async {
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=9bb7bf6152d147ad8ba14cd0e7452f2f";
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      setState(() {
        data["articles"].forEach((element) {
          QueryModel queryModel = new QueryModel();
          queryModel = QueryModel.fromMap(element);
          modelList.add(queryModel);
          setState(() {
            isLoading = false;
          });
        });
      });
    } catch (e) {
      print(e);

      return Container();
    }
  }

  @override
  void initState() {
    getByQuery();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: isLoading
            ? Container(
                height: 500, child: Center(child: CircularProgressIndicator()))
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  try {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 1.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  child: Image.network(
                                    modelList[index].queryImg,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black12.withOpacity(0),
                                            Colors.black
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 8),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              modelList[index].queryHead,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              modelList[index].queryDes.length >
                                                      50
                                                  ? "${modelList[index].queryDes.substring(0, 55)}...."
                                                  : modelList[index].queryDes,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  } catch (e) {
                    return Container();
                  }
                }),
      ),
    );
  }
}
