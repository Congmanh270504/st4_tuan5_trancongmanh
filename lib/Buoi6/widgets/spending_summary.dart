import 'package:flutter/material.dart';

class SpendingSummary extends StatelessWidget {
  final double totalAmount;

  const SpendingSummary({Key? key, required this.totalAmount})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Total Spending',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(context, 'Today', '\$45.50', Icons.today),
              _buildSummaryItem(
                context,
                'This Week',
                '\$352.24',
                Icons.calendar_view_week,
              ),
              _buildSummaryItem(
                context,
                'This Month',
                '\$1,245.80',
                Icons.calendar_today,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String title,
    String amount,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
