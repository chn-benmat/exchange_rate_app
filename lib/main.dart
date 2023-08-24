import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';
import 'ExchangeRateBox.dart';

void main() {
  runApp(MyApp());
}

// สร้าง StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

// สร้าง StatefulWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ExchangRate _dataFromAPI;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

// สร้าง เมธอด การดึงข้อมุลจาก api
  Future<ExchangRate> getExchangeRate() async {
    var url =
        "http://api.exchangeratesapi.io/v1/latest?&access_key=db380e64b6237e0ae7169b7eeca10cae";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return _dataFromAPI =
        exchangRateFromJson(response.body); //json => dart object
  }

  // โชว์ data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อัตราการแลกเปลี่ยนสกุลเงิน",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<ExchangRate>(
        future:
            getExchangeRate(), // ใช้ตัวแปร future ที่เรียก getExchangeRate()
        builder: (BuildContext context, AsyncSnapshot<ExchangRate> snapshot) {
          //ดึงข้อมูล getExchangeRatr มาครบเรียบร้อยจะให้ทำไร
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data!;
            double amount = 1;
            
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ExchangeRateBox("เงินเริ่มต้น", amount ,"ยูโร", Colors.lightBlue, 120),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["THB"]!).toDouble()   ,"บาท", Colors.green, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["USD"]!) ,"ดอลลาร์สหรัฐ", Colors.red, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["GBP"]!) ,"ปอนด์สเตอร์ลิง", Colors.yellow, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["GNF"]!) ,"ฟรังก์กินี", Colors.orange, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["AMD"]!) ,"ดรัมอาร์มีเนีย", Colors.pink, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["BSD"]!) ,"ดอลลาร์บาฮามาส", Colors.deepPurple, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["BAM"]!) ,"คอนเวร์ทีบิลมาร์คบอสเนีย", Colors.tealAccent, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["BBD"]!) ,"ดอลลาร์บาร์เบโดส", Colors.purple, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["CAD"]!) ,"ดอลลาร์แคนาดา", Colors.limeAccent, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["CDF"]!) ,"ฟรังก์คองโก", Colors.amber, 100),
                    SizedBox(height: 5,),
                    ExchangeRateBox("เท่ากับ : ", (amount * result.rates["CHF"]!) ,"ฟรังก์สวิส", Colors.cyan, 100),
                  ],
                ),
              ),
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}
