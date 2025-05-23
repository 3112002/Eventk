String formatPhoneNumberToLocal(String phone) {
  if (!phone.startsWith('0')) {
    return '0' + phone;
  }
  return phone;
}
