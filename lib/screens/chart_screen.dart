import 'package:flutter/material.dart';

class Chart extends StatefulWidget{
  const Chart({Key? key}): super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 70,
            color: Colors.red,
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                  ),
                  child: Text("Hello"),
                ),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                  ),
                  child: Text("Hello"),
                ),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                  ),
                  child: Text("Hello"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}