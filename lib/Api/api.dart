class Api {
  static getSegmentValue() async {
    Api.segment = '?api_password=eth_pal48ps&lang=ar';
  }

  static String url = "https://www.pal48.ps";
  // static String url = "http://pal48.test";
  // static String url = "http://10.0.2.2:8000";

  static String apiUrl = '$url/api';

  static String segment = '';

  static String getContactData() {
    return "${Api.apiUrl}/getContactData${Api.segment}";
  }

  // static String getCityVillage(id) {
  //   return "${Api.apiUrl}/getCityVillage/$id${Api.segment}";
  // }

  static String getNotifications() {
    return "${Api.apiUrl}/getNotifications/${Api.segment}";
  }

  static String getStory() {
    return "${Api.apiUrl}/story/${Api.segment}";
  }

  static String getCamps(int page, List country) {
    // ignore: prefer_interpolation_to_compose_strings
    return Api.apiUrl +
        "/camps/" +
        country.join(",") +
        Api.segment +
        '&page=' +
        page.toString();
  }

  static String getVillages(int cityId, int page) {
    // ignore: prefer_interpolation_to_compose_strings
    return Api.apiUrl +
        "/city/" +
        cityId.toString() +
        Api.segment +
        '&page=' +
        page.toString();
  }

  static String getMainNakbaCat() {
    return "${Api.apiUrl}/nakba/${Api.segment}";
  }

  static String getSubNakbaCat(int id) {
    return "${Api.apiUrl}/nakba/$id/${Api.segment}";
  }

  static String blabla() {
    return "${Api.apiUrl}/nakba/${Api.segment}";
  }

  static String getAqsaMainCat() {
    return "${Api.apiUrl}/aqsa/${Api.segment}";
  }

  static String getSubAqsaCat(id) {
    return "${Api.apiUrl}/aqsa/$id/${Api.segment}";
  }

  static String getVideos(int page) {
    return "${Api.apiUrl}/videos${Api.segment}&page=${page.toString()}";
  }

  static String getQuestionsCat() {
    return "${Api.apiUrl}/questionCat/${Api.segment}";
  }

  static String getQuestions(int id) {
    return "${Api.apiUrl}/questions/$id/${Api.segment}";
  }

  static String fetchPlace(int page, List country) {
    // ignore: prefer_interpolation_to_compose_strings
    return Api.apiUrl +
        "/place/" +
        country.join(",") +
        Api.segment +
        '&page=' +
        page.toString();
  }

  static String fetchMassacre(int page) {
    // ignore: prefer_interpolation_to_compose_strings
    return "${Api.apiUrl}/massacre${Api.segment}" '&page=' + page.toString();
  }

  static String fetchArticles(int page) {
    // ignore: prefer_interpolation_to_compose_strings
    return "${Api.apiUrl}/articles${Api.segment}" '&page=' + page.toString();
  }

  static String fetchArticleById(int id) {
    return "${Api.apiUrl}/articles/$id${Api.segment}";
  }

  static String getPrivacy() {
    return "${Api.apiUrl}/gerPrivacyData${Api.segment}";
  }

  static String getTerms() {
    return "${Api.apiUrl}/gerTermsData${Api.segment}";
  }

  static String sendMessage() {
    return "${Api.apiUrl}/sendMessage${Api.segment}";
  }

  static String addComment() {
    return "${Api.apiUrl}/addComment${Api.segment}";
  }

  static String fetchComments(int id) {
    return "${Api.apiUrl}/getComment/$id${Api.segment}";
  }

  static String fetchEvents(int month, int day) {
    return "${Api.apiUrl}/getEvents/$month/$day${Api.segment}";
  }

  static String searchArticles(String query, int follow) {
    return "${Api.apiUrl}/search/$follow${Api.segment}";
  }
}
