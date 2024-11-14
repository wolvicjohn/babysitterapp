import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  // Function to show confirmation dialog
  Future<void> _showConfirmationDialog(VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content:
              const Text('Are you sure you want to proceed with the payment?'),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  // Navigate to Success Screen
  void _navigateToSuccessScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SuccessScreen(),
      ),
    );
  }

  // Payment functions
  void _payWithGCash() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount for GPay')),
      );
      return;
    }

    _showConfirmationDialog(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing payment with GPay...')),
      );
      Future.delayed(const Duration(seconds: 2), () {
        _navigateToSuccessScreen();
      });
    });
  }

  void _payWithDirectPay() {
    _showConfirmationDialog(() {
      _navigateToSuccessScreen();
    });
  }

  void _payWithCreditCard() {
    if (_formKey.currentState?.validate() ?? false) {
      _showConfirmationDialog(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Processing payment with Credit Card...')),
        );
        Future.delayed(const Duration(seconds: 2), () {
          _navigateToSuccessScreen();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Choose Payment Method:',
                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                // Payment options grid
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  children: [
                    _buildPaymentOption(
                      label: 'GPay',
                      iconPath:
                          'assets/images/gpay.png', // Update path as needed
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'GPay';
                        });
                      },
                    ),
                    _buildPaymentOption(
                      label: 'Cash Upon Arrival',
                      iconPath:
                          'assets/images/cua.png', // Update path as needed
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'Direct Pay';
                        });
                        _payWithDirectPay();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // GPay Amount Field
                if (_selectedPaymentMethod == 'GPay')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Enter Amount',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                // Payment Form (only for Credit Card)
                if (_selectedPaymentMethod == 'Credit Card')
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Card Number',
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          validatorMessage: 'Please enter your card number',
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          label: 'Expiry Date',
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.datetime,
                          validatorMessage: 'Please enter the expiry date',
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          label: 'CVV',
                          icon: Icons.lock,
                          keyboardType: TextInputType.number,
                          validatorMessage: 'Please enter the CVV',
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _payWithCreditCard,
                          icon: const Icon(Icons.credit_card),
                          label: const Text('Pay with Credit Card'),
                          style: _elevatedButtonStyle(),
                        ),
                      ],
                    ),
                  ),

                // Pay Button for GPay
                if (_selectedPaymentMethod == 'GPay')
                  ElevatedButton(
                    onPressed: _payWithGCash,
                    style: _elevatedButtonStyle(),
                    child: const Text('Pay with GPay'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontFamily: 'Poppins')),
          ],
        ),
      ),
    );
  }

  ButtonStyle _elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      textStyle: const TextStyle(fontFamily: 'Poppins'),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String validatorMessage,
    bool obscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
    );
  }
}

// Success Screen
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success',
            style: TextStyle(fontFamily: 'Poppins')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.deepPurple, size: 80),
            SizedBox(height: 20),
            Text(
              'Congratulations!',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You have successfully paid.',
              style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
