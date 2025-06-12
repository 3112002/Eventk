double calculateTotalPrice(List tickets, List<int> selectedCounts) {
  double total = 0;
  for (int i = 0; i < tickets.length; i++) {
    total += tickets[i].price * selectedCounts[i];
  }
  return total;
}
