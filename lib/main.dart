import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(title: 'My Calculator'),
  );
}

class MyApp extends StatefulWidget {
  final String title;
  const MyApp({super.key, required this.title});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double? firstValue;
  double? secondValue;
  double? result;
  String? selectedOperator;

  bool isAnyValueNull() {
    if (firstValue == null || secondValue == null) {
      return true;
    } else {
      return false;
    }
  }

  calculate() {
    if (isAnyValueNull()) return;

    switch (selectedOperator) {
      case "+":
        result = firstValue! + secondValue!;
        break;
      case "-":
        result = firstValue! - secondValue!;
        break;
      case "*":
        result = firstValue! * secondValue!;
        break;
      case "/":
        result = firstValue! / secondValue!;
        break;
    }

    setState(() {
      result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(widget.title),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    firstValue = double.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter first number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    secondValue = double.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter second number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OperatorButton(
                    onTap: () => {setState(() => selectedOperator = "+")},
                    selectedOperator: selectedOperator,
                    labelOperator: "+",
                  ),
                  OperatorButton(
                    onTap: () => {setState(() => selectedOperator = "-")},
                    selectedOperator: selectedOperator,
                    labelOperator: "-",
                  ),
                  OperatorButton(
                    onTap: () => {setState(() => selectedOperator = "*")},
                    selectedOperator: selectedOperator,
                    labelOperator: "*",
                  ),
                  OperatorButton(
                    onTap: () => {setState(() => selectedOperator = "/")},
                    selectedOperator: selectedOperator,
                    labelOperator: "/",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () => calculate(),
                  child: Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      color: isAnyValueNull() ? Colors.grey : Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Calculate",
                        style: (TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              if (result != null)
                Center(
                  child: Text(
                    result.toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  final String? selectedOperator;
  final String labelOperator;
  final Function() onTap;

  const OperatorButton(
      {super.key,
      required this.selectedOperator,
      required this.labelOperator,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: selectedOperator == labelOperator ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            labelOperator,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
