bool isNetworkImage(String url) {
  return url.startsWith('http://') || url.startsWith('https://');
}